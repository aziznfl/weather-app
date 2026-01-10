//
//  WeatherCardItem+Ext.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 10/01/26.
//

extension WeatherCardItem {
    static func makeAll(
        type: WeatherType,
        location: String
    ) -> [WeatherCardItem] {
        [
            .init(size: .small, type: type, location: location),
            .init(size: .medium, type: type, location: location),
            .init(size: .large, type: type, location: location)
        ]
    }
}
