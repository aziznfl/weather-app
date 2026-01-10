//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 31/12/25.
//

import Alamofire

final class WeatherService: WeatherServiceProtocol {
    static let shared: WeatherService = WeatherService()
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getCurrentWeather(body: WeatherRequest) async -> Result<WeatherResponse, BaseError> {
        let response: Result<WeatherResponse, Error> = await apiClient.request(
            url: APIConstants.weatherURL,
            method: .get,
            body: body
        )

        switch response {
        case .success(let weather):
            return .success(weather)
        case .failure(let error):
            // Map NetworkError.api to BaseError; otherwise, provide a fallback
            if let networkError = error as? NetworkError {
                switch networkError {
                case .api(let code, let message):
                    return .failure(BaseError(statusCode: code, message: message))
                default:
                    return .failure(BaseError(statusCode: -1, message: "Network error"))
                }
            } else {
                return .failure(BaseError(statusCode: -1, message: error.localizedDescription))
            }
        }
    }
}
