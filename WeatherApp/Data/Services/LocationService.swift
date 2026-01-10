//
//  LocationService.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 01/01/26.
//

import CoreLocation

enum LocationError: LocalizedError {
    case permissionDenied
    case unknown

    var errorDescription: String? {
        switch self {
        case .permissionDenied:
            return "Location permission denied"
        case .unknown:
            return "Unknown location error"
        }
    }
}

final class LocationService: NSObject, LocationServiceProtocol {
    static let shared: LocationService = LocationService()
    
    private let locationManager = CLLocationManager()
    private var continuation: CheckedContinuation<Result<CLLocationCoordinate2D, Error>, Never>?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func getCurrentLocation() async -> Result<CLLocationCoordinate2D, Error> {
        return await withCheckedContinuation { continuation in
            self.continuation = continuation

            let status = CLLocationManager.authorizationStatus()

            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()

            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.requestLocation()

            case .denied, .restricted:
                continuation.resume(
                    returning: .failure(LocationError.permissionDenied)
                )
                self.continuation = nil

            @unknown default:
                continuation.resume(
                    returning: .failure(LocationError.unknown)
                )
                self.continuation = nil
            }
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()

        case .denied, .restricted:
            continuation?.resume(
                returning: .failure(LocationError.permissionDenied)
            )
            continuation = nil

        default:
            break
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        continuation?.resume(
            returning: .success(location.coordinate)
        )
        continuation = nil
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        continuation?.resume(
            returning: .failure(error)
        )
        continuation = nil
    }
}
