//
//  MockLocationRepository.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 10/01/26.
//

final class MockLocationRepository: LocationRepositoryProtocol {
    var result: Result<Location, BaseError>!

    func getCurrentLocation() async -> Result<Location, BaseError> {
        return result
    }
}
