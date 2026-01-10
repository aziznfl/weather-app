//
//  RetrieveWeatherUseCase.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 31/12/25.
//

import WidgetKit

final class RetrieveWeatherUseCase: RetrieveWeatherUseCaseProtocol {
    private let locationRepository: LocationRepositoryProtocol
    private let weatherRepository: WeatherRepositoryProtocol
    
    init(
        locationRepository: LocationRepositoryProtocol,
        weatherRepository: WeatherRepositoryProtocol
    ) {
        self.locationRepository = locationRepository
        self.weatherRepository = weatherRepository
    }
    
    func execute() async -> Result<Weather, BaseError> {
        let locationResult = await locationRepository.getCurrentLocation()
        
        switch locationResult {
        case .success(let location):
            let result = await weatherRepository.getCurrentWeatherFrom(location: location)
            
            if #available(iOS 14.0, *) {
                WidgetCenter.shared.reloadTimelines(ofKind: weatherWidgetKey)
            }
            
            return result
        case .failure(let error):
            return .failure(error)
        }
    }
}
