//
//  BaseError.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 02/01/26.
//

struct BaseError: Error {
    let statusCode: Int
    let message: String
}
