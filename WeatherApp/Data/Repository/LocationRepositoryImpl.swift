//
//  LocationRepositoryImpl.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 02/01/26.
//

import CoreLocation

final class LocationRepository: LocationRepositoryProtocol {
    static let shared: LocationRepository = LocationRepository()
    
    private let service: LocationServiceProtocol
    
    init(service: LocationServiceProtocol = LocationService.shared) {
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
  
