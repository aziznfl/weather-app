//
//  ErrorResponse.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 02/01/26.
//

struct WeatherErrorResponse: Decodable {
    let code: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
    }
}
