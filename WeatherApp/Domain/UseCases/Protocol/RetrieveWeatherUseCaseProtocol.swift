//
//  RetrieveWeatherUseCaseProtocol.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 10/01/26.
//

protocol RetrieveWeatherUseCaseProtocol {
    func execute() async -> Result<Weather, BaseError>
}
