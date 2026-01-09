//
//  GetLastFetchWeatherUseCase.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 04/01/26.
//

import Foundation

final class GetLastFetchWeatherUseCase {
    let repository = WeatherRepositoryImpl()
    
    func execute() -> Date? {
        return repository.getLastFetchedAt()
    }
}
