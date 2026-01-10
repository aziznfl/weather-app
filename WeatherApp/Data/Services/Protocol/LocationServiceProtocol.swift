//
//  LocationServiceProtocol.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 10/01/26.
//

import CoreLocation

protocol LocationServiceProtocol {
    func getCurrentLocation() async -> Result<CLLocationCoordinate2D, Error>
}
