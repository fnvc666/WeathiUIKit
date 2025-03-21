//
//  MainViewModel.swift
//  Weathi
//
//  Created by on 09/03/2025.
//
class WeatherViewModel {
    var weatherData: Observable<WeatherData> = Observable(nil)
    
    func loadWeather(for city: String) {
        WeatherService.shared.fetchWeather(for: city) { [weak self] result in
            switch result {
                case .success(let data):
                    self?.weatherData.value = data
                    print("succes: \(data)")
                case .failure(let error):
                    print("error: \(error)")
            }
        }
    }
}
