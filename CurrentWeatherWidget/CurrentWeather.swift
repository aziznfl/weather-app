//
//  CurrentWeather.swift
//  CurrentWeather
//
//  Created by Aziz Nurfalah on 31/12/25.
//

import SwiftUI
import WidgetKit

struct WeatherEntry: TimelineEntry {
    let date: Date
    let item: WeatherCardItem
    let backgroundImage: UIImage?
}

struct CurrentWeatherWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: weatherWidgetKey,
            provider: CurrentWeatherProvider()
        ) { entry in
            CurrentWeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Current Weather")
        .description("Shows current weather with custom background.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct CurrentWeatherWidgetEntryView: View {
    let entry: WeatherEntry

    var body: some View {
        CurrentWeatherCardView(
            item: entry.item,
            backgroundImage: entry.backgroundImage,
            isWidget: true
        )
    }
}

extension CardLayout {
    static func from(_ family: WidgetFamily) -> CardLayout {
        switch family {
        case .systemSmall:
            return .small
        case .systemMedium:
            return .medium
        case .systemLarge:
            return .large
        default:
            return .small
        }
    }
}
