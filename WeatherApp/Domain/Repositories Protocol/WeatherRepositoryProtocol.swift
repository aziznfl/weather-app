//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 31/12/25.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func getCurrentWeatherFrom(location: Location) async -> Result<Weather, BaseError>
    func getCachedWeather() async -> Weather?
    func save(weather: Weather) async
    func getLastFetchedAt() -> Date?
}
