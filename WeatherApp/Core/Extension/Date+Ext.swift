//
//  Date+Ext.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 05/01/26.
//

import Foundation

extension Date {
    func toText() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "dd MMM yyyy, HH:mm"
        return formatter.string(from: self)
    }
}
