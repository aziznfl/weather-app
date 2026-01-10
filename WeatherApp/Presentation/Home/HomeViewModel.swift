//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 02/01/26.
//

import Foundation

@MainActor
final class HomeViewModel {
    var onCurrentWeatherLoaded: ((Weather) -> Void)?
    var onError: ((BaseError) -> Void)?

    private let retrieveWeatherUseCase: RetrieveWeatherUseCaseProtocol
    private var task: Task<Void, Never>?

    init(
        retrieveWeatherUseCase: RetrieveWeatherUseCaseProtocol
    ) {
        self.retrieveWeatherUseCase = retrieveWeatherUseCase
    }

    func start() {
        stop()

        task = Task {
            await fetchLoop()
        }
    }

    func stop() {
        task?.cancel()
        task = nil
    }

    private func fetchLoop() async {
        while !Task.isCancelled {
            let result = await retrieveWeatherUseCase.execute()

            switch result {
            case .success(let weather):
                onCurrentWeatherLoaded?(weather)

            case .failure(let error):
                onError?(error)
            }

            try? await Task.sleep(
                nanoseconds: 60 * 1_000_000_000
            )
        }
    }
}
