//
//  WeatherLocalDataSource.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 02/01/26.
//

import Foundation

final class WeatherLocalDataSource {
    static let shared: WeatherLocalDataSource = .init()
    
    private let weatherKey = "cached_weather"
    private let lastFetchKey = "weather_last_fetch"
    private let defaults = UserDefaults(suiteName: groupAppName)

    func save(_ weather: Weather) {
        if let data = try? JSONEncoder().encode(weather) {
            defaults?.set(data, forKey: weatherKey)
            defaults?.set(Date(), forKey: lastFetchKey)
        }
    }

    func load() -> Weather? {
        guard
            let data = defaults?.data(forKey: weatherKey),
            let dto = try? JSONDecoder().decode(Weather.self, from: data)
        else {
            return nil
        }
        return dto
    }
    
    func lastFetchedAt() -> Date? {
        defaults?.object(forKey: lastFetchKey) as? Date
    }
}
