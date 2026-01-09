//
//  CurrentWeatherProvider.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 07/01/26.
//

import WidgetKit
import UIKit

struct CurrentWeatherProvider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(
            date: Date(),
            item: demoItem(for: .systemSmall),
            backgroundImage: nil
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        completion(
            WeatherEntry(
                date: Date(),
                item: demoItem(for: .systemSmall),
                backgroundImage: nil
            )
        )
    }

    func getTimeline(in context: Context,
                     completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        let entry = WeatherEntry(
            date: Date(),
            item: loadItem(for: context.family),
            backgroundImage: loadBackgroundImage()
        )

        completion(
            Timeline(
                entries: [entry],
                policy: .after(Date().addingTimeInterval(60))
            )
        )
    }
    
    // MARK: - Demo (Preview / Placeholder)

    private func demoItem(for family: WidgetFamily) -> WeatherCardItem {
        WeatherCardItem(
            size: .from(family),
            type: .clouds,
            location: "Bandung"
        )
    }

    // MARK: - Real data (Widget-safe)

    private func loadItem(for family: WidgetFamily) -> WeatherCardItem {
        if let cacheData = WeatherLocalDataSource.shared.load() {
            return WeatherCardItem(
                size: .from(family),
                type: cacheData.type,
                location: "\(cacheData.location.name), \(cacheData.location.countryCode)"
            )
        } else {
            return WeatherCardItem(
                size: .from(family),
                type: .sun,
                location: "Please use the app first"
            )
        }
    }
    
    private func loadBackgroundImage() -> UIImage? {
        guard let pathString = BackgroundDataSource.shared.load() else { return nil }
        return UIImage(contentsOfFile: pathString)
    }
}
