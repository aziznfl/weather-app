//
//  Weather.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 31/12/25.
//

struct WeatherResponse: Decodable, Sendable {
    let name: String
    let weather: [WeatherWeatherResponse]
    let main: WeatherMainResponse
    let sys: WeatherSysResponse
}

struct WeatherWeatherResponse: Decodable, Sendable {
    let id: Int
    let main: String
}

struct WeatherMainResponse: Decodable, Sendable {
    let temp: Double
    let feelsLike: Double
    let humidity: Double
    let seaLevel: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case humidity
        case seaLevel = "sea_level"
    }
}

struct WeatherSysResponse: Decodable, Sendable {
    let country: String
}
