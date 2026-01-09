//
//  BackgroundDataSource.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 08/01/26.
//

import Foundation

final class BackgroundDataSource {
    static let shared: BackgroundDataSource = .init()
    
    private let backgroundKey = "cached_background"
    private let defaults = UserDefaults(suiteName: groupAppName)

    func save(_ path: String) {
        defaults?.set(path, forKey: backgroundKey)
    }

    func load() -> String? {
        guard let path = defaults?.string(forKey: backgroundKey)
        else {
            return nil
        }
        return path
    }
}
