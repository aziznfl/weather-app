//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 10/01/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = HomeComposer.vc()
        window.makeKeyAndVisible()

        self.window = window
    }
}
