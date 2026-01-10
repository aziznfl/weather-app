//
//  RetrieveWeatherUseCaseTests.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 10/01/26.
//

import XCTest

final class RetrieveWeatherUseCaseTests: XCTestCase {

    func test_execute_success_shouldReturnWeather() async {
        // Arrange
        let mockLocationRepository = MockLocationRepository()
        let mockWeatherRepository = MockWeatherRepository()

        let location = Location(latitude: 1.0, longitude: 2.0)
        let weather = Weather(
            id: 1,
            type: .sun,
            location: WeatherLocation(name: "Bandung", countryCode: "ID")
        )

        mockLocationRepository.result = .success(location)
        mockWeatherRepository.result = .success(weather)

        let useCase = RetrieveWeatherUseCase(
            locationRepository: mockLocationRepository,
            weatherRepository: mockWeatherRepository
        )

        // Act
        let result = await useCase.execute()

        // Assert
        switch result {
        case .success(let returnedWeather):
            XCTAssertEqual(returnedWeather.type, weather.type)
            XCTAssertEqual(returnedWeather.location.name, weather.location.name)
        case .failure:
            XCTFail("Expected success, got failure")
        }
    }
    
    func test_execute_locationFailure_shouldReturnError() async {
        // Arrange
        let mockLocationRepository = MockLocationRepository()
        let mockWeatherRepository = MockWeatherRepository()

        let expectedError = BaseError(statusCode: 429, message: "Location Not Found")

        mockLocationRepository.result = .failure(expectedError)

        let useCase = RetrieveWeatherUseCase(
            locationRepository: mockLocationRepository,
            weatherRepository: mockWeatherRepository
        )

        // Act
        let result = await useCase.execute()

        // Assert
        switch result {
        case .success:
            XCTFail("Expected failure, got success")
        case .failure(let error):
            XCTAssertEqual(error, expectedError)
        }
    }
    
    func test_execute_weatherFailure_shouldReturnError() async {
        // Arrange
        let mockLocationRepository = MockLocationRepository()
        let mockWeatherRepository = MockWeatherRepository()

        let location = Location(latitude: 1.0, longitude: 2.0)
        let expectedError = BaseError(statusCode: 400, message: "Data Not Found")

        mockLocationRepository.result = .success(location)
        mockWeatherRepository.result = .failure(expectedError)

        let useCase = RetrieveWeatherUseCase(
            locationRepository: mockLocationRepository,
            weatherRepository: mockWeatherRepository
        )

        // Act
        let result = await useCase.execute()

        // Assert
        switch result {
        case .success:
            XCTFail("Expected failure, got success")
        case .failure(let error):
            XCTAssertEqual(error, expectedError)
        }
    }
}
