//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 02/01/26.
//

enum NetworkError: Error {
    case api(code: Int, message: String)
    case decoding
    case transport(Error)
    case unknown
}
