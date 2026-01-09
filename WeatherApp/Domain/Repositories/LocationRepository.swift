//
//  LocationRepository.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 01/01/26.
//

protocol LocationRepository {
    func getCurrentLocation() async -> Result<Location, BaseError>
}
