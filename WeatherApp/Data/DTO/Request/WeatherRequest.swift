//
//  Weather.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 31/12/25.
//

struct WeatherRequest: Encodable {
    let latitude: String
    let longitude: String
    let appId: String
    let units: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case appId
        case units
    }
}
