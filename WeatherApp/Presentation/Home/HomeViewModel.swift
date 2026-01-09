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
    
    func initCurrentWeather() {
        fetchCurrentWeather()
    }
    
    private func fetchCurrentWeather() {
        Task {
            while !Task.isCancelled {
                let result = await RetrieveWeatherUseCase().execute()
                
                switch result {
                case .success(let weather):
                    onCurrentWeatherLoaded?(weather)
                case .failure(let error):
                    onError?(error)
                }
                
                try? await Task.sleep(nanoseconds: 60 * 1_000_000_000)
            }
        }
    }
}
