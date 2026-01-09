//
//  WeatherType.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 06/01/26.
//

public enum WeatherType: Codable {
    case sun
    case clouds
    case sunUnderCloud
    case rain
    case snow
    
    static func getType(name: String) -> Self {
        switch name {
        case "Sunny":
            return .sun
        case "Clouds":
            return .clouds
        case "Rain":
            return .rain
        default:
            return .sun
        }
    }
    
    var iconName: String {
        switch self {
        case .sun:
            return "Sunny"
        case .clouds:
            return "Cloud"
        case .sunUnderCloud:
            return "Sun Under Cloud"
        case .rain:
            return "Rain"
        case .snow:
            return "Snow"
        }
    }
}
