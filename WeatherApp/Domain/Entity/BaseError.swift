//
//  BaseError.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 02/01/26.
//

struct BaseError: Error, Equatable {
    let statusCode: Int
    let message: String
}
