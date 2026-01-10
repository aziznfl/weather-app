//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 10/01/26.
//

protocol WeatherServiceProtocol {
    func getCurrentWeather(body: WeatherRequest) async -> Result<WeatherResponse, BaseError>
}
