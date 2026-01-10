//
//  MockWeatherRepository.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 10/01/26.
//

import Foundation

final class MockWeatherRepository: WeatherRepositoryProtocol {
    var result: Result<Weather, BaseError>!

    func getCurrentWeatherFrom(location: Location) async -> Result<Weather, BaseError> {
        return result
    }

    func getCachedWeather() async -> Weather? {
        // Return a stub or nil for test
        return nil
    }

    func save(weather: Weather) async {
        // No-op for mock
    }

    func getLastFetchedAt() -> Date? {
        // Return a stub or nil for test
        return nil
    }
}
