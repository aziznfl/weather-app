//
//  LocationRepositoryImpl.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 02/01/26.
//

import CoreLocation

final class LocationRepositoryImpl: LocationRepository {
    private let service: LocationService
    
    init(service: LocationService = LocationServiceImpl()) {
        self.service = service
    }
    
    func getCurrentLocation() async -> Result<Location, BaseError> {
        let result = await service.getCurrentLocation()
        
        switch result {
        case .success(let data):
            return .success(Location(latitude: data.latitude, longitude: data.longitude))
        case .failure(let error):
            return .failure(
                BaseError(
                    statusCode: 424,
                    message: error.localizedDescription
                )
            )
        }
    }
}
  
