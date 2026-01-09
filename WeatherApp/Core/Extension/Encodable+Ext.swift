//
//  Encodable.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 31/12/25.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data)
        return json as? [String: Any] ?? [:]
    }
}
