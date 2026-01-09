//
//  Weather.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 02/01/26.
//

struct WeatherCardItem {
    let size: CardLayout
    let type: WeatherType
    let location: String
}

struct Weather: Codable {
    let id: Int
    let type: WeatherType
    let location: WeatherLocation
    let temperature: Temperature
}

struct WeatherLocation: Codable {
    let name: String
    let countryCode: String
}

struct Temperature: Codable {
    let actual: Double
    let feelsLike: Double
}
