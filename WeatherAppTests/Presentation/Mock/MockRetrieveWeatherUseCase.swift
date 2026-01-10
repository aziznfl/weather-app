//
//  MockRetrieveWeatherUseCase.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 10/01/26.
//

class MockRetrieveWeatherUseCase: RetrieveWeatherUseCaseProtocol {
    func execute() async -> Result<Weather, BaseError> {
        return .failure(BaseError(statusCode: 400, message: "Not found"))
    }
}
