//
//  CardLayout.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 06/01/26.
//

import SwiftUI
import WidgetKit

enum CardLayout: CaseIterable {
    case small
    case medium
    case large
    
    var size: CGSize {
        switch self {
        case .small:
            return CGSize(width: 155, height: 155)
        case .medium:
            return CGSize(width: 329, height: 155)
        case .large:
            return CGSize(width: 329, height: 345)
        }
    }
    
    var paddingBetween: CGFloat {
        switch self {
        case .large:
            return 42
        default:
            return 10
        }
    }
    
    var alignment: HorizontalAlignment {
        switch self {
        case .medium:
            return .leading
        default:
            return .center
        }
    }
    
    var font: Font {
        switch self {
        case .small:
            return .system(size: 18, weight: .bold)
        case .medium:
            return .system(size: 24, weight: .bold)
        case .large:
            return .system(size: 32, weight: .bold)
        }
    }
    
    static var longestWidth: Double {
        allCases
            .map { $0.size.width }
            .max() ?? 0
    }
}
