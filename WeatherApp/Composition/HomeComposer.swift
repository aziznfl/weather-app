//
//  HomeComposer.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 10/01/26.
//

import UIKit

enum HomeComposer {
    static func vc() -> UIViewController {
        let storyboardVC = HomeViewController.instantiate(from: "HomeView")

        let useCase = RetrieveWeatherUseCase(
            locationRepository: LocationRepository.shared,
            weatherRepository: WeatherRepository.shared
        )
        let viewModel = HomeViewModel(
            retrieveWeatherUseCase: useCase
        )

        storyboardVC.viewModel = viewModel
        storyboardVC.alertFactory = DefaultLocationPermissionAlertFactory()
        storyboardVC.errorView = ErrorView()

        return UINavigationController(rootViewController: storyboardVC)
    }
}
