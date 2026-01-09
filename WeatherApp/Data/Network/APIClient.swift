//
//  APIClient.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 31/12/25.
//

import Alamofire

struct EmptyBody: Encodable {}

final class APIClient {
    private let session: Session
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        
        self.session = Session(configuration: configuration)
    }
    
    // Overload for requests without a body.
    func request<T: Decodable>(
        url: String,
        method: HTTPMethod
    ) async -> Result<T, Error> {
        await request(url: url, method: method, body: Optional<EmptyBody>.none)
    }
    
    func request<E: Encodable, T: Decodable>(
        url: String,
        method: HTTPMethod,
        body: E? = nil
    ) async -> Result<T, Error> {
        await withCheckedContinuation { continuation in
            do {
                let urlRequest = try generateUrlRequest(url: url, method: method, body: body)
                session.request(urlRequest)
                    .validate(statusCode: 200..<300)
                    .responseData { [weak self] response in
                        switch response.result {
                        case .success(let data):
                            do {
                                let decoded = try JSONDecoder().decode(T.self, from: data)
                                continuation.resume(returning: .success(decoded))
                            } catch {
                                continuation.resume(returning: .failure(CancellationError()))
                            }
                        case .failure(_):
                            guard let error = self?.errorResponse(data: response.data) else {
                                return continuation.resume(returning: .failure(CancellationError()))
                            }
                            
                            continuation.resume(returning: .failure(
                                NetworkError.api(code: error.code, message: error.message))
                            )
                        }
                    }
            } catch {
                continuation.resume(returning: .failure(CancellationError()))
            }
        }
    }
    
    private func generateUrlRequest<E: Encodable>(
        url: String,
        method: HTTPMethod,
        body: E? = nil
    ) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: url) else {
            throw URLError(.badURL)
        }
        
        var urlRequest: URLRequest
        
        switch method {
        case .get:
            if let body {
                let params = try body.toDictionary()
                urlComponents.queryItems = params.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
            }
            
            guard let finalURL = urlComponents.url else {
                throw URLError(.badURL)
            }
            
            urlRequest = try URLRequest(url: finalURL, method: method)
        default:
            urlRequest = try URLRequest(url: url, method: method)
            
            if let body {
                urlRequest.httpBody = try JSONEncoder().encode(body)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
        
        return urlRequest
    }
    
    private func errorResponse(data: Data?) -> WeatherErrorResponse? {
        guard let data else { return nil }
        
        do {
            let apiError = try JSONDecoder().decode(WeatherErrorResponse.self, from: data)

            return apiError
        } catch {
            return nil
        }
    }
}
