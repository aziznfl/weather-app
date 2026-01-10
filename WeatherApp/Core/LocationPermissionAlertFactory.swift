//
//  LocationPermissionAlertFactory.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 10/01/26.
//

import UIKit

protocol LocationPermissionAlertFactory {
    func makeAlert(
        settingsHandler: @escaping (UIAlertAction) -> Void
    ) -> UIAlertController
}

struct DefaultLocationPermissionAlertFactory: LocationPermissionAlertFactory {
    func makeAlert(
        settingsHandler: @escaping (UIAlertAction) -> Void
    ) -> UIAlertController {

        let alert = UIAlertController(
            title: "Location Permission Needed",
            message: "Please enable location access in Settings to get your current weather.",
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(title: "Close", style: .cancel)
        )

        alert.addAction(
            UIAlertAction(
                title: "Go to Settings",
                style: .default,
                handler: settingsHandler
            )
        )

        return alert
    }
}
