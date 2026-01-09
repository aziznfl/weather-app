//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 30/12/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController.instantiate(from: "HomeView")
        vc.viewModel = HomeViewModel()
        let rootVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()

        return true
    }
}
