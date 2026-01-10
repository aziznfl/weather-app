//
//  WeatherRepositoryImpl.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 02/01/26.
//

import Foundation

final class WeatherRepository: WeatherRepositoryProtocol {
    static let shared: WeatherRepository = WeatherRepository()
    
    private let service: WeatherServiceProtocol
    private let local: WeatherLocalDataSource
    
    init(service: WeatherServiceProtocol = WeatherService(),
         local: WeatherLocalDataSource = .shared) {
        self.service = service
        self.local = local
    }
    
    func getCurrentWeatherFrom(location: Location) async -> Result<Weather, BaseError> {
        let request = WeatherRequest(
            latitude: "\(location.latitude)",
            longitude: "\(location.longitude)",
            appId: AppEnvironment.weatherApiKey,
            units: "metric"
        )
        
        let weatherResult = await service.getCurrentWeather(body: request)
        
        switch weatherResult {
        case .success(let weatherDto):
            // generate the weather
            let data = Weather(
                id: weatherDto.weather.first!.id,
                type: WeatherType.getType(name: weatherDto.weather.first!.main),
                location: WeatherLocation(
                    name: weatherDto.name,
                    countryCode: weatherDto.sys.country
                )
            )
            
            // save to local
            local.save(data)
            
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getCachedWeather() async -> Weather? {
        local.load()
    }
    
    func getLastFetchedAt() -> Date? {
        local.lastFetchedAt()
    }
    
    func save(weather: Weather) async {
        local.save(weather)
    }
}
