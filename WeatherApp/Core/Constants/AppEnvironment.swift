//
//  AppEnvironment.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 02/01/26.
//

import Foundation

enum AppEnvironment {
    static var weatherApiKey: String {
        guard
            let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? [String: String],
            let weatherKey = key["WEATHER"]
        else { fatalError("Missing WEATHER API key") }
        return weatherKey
    }
}
