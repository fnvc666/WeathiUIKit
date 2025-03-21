//
//  HistoryViewModel.swift
//  Weathi
//
//  Created by on 09/03/2025.
//

import Foundation

class HistoryViewModel {
    
    var historyWeatherData: Observable<[HistoryWeatherData]> = Observable([])

    func loadHistory(for city: String, days: Int = 10) {
        var weatherDataArray: [HistoryWeatherData] = []
        let group = DispatchGroup()
        let now = Date()
        
        for i in 0..<days {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: now) ?? now
            group.enter()
            
            WeatherService.shared.fetchHistoryWeather(for: city, date: date) { result in
                switch result {
                case .success(let data):
                    weatherDataArray.append(data)
                    print("Success: \(data)")
                case .failure(let error):
                    print("Failed to load history for date \(date): \(error)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            let sortedArray = weatherDataArray.sorted {
                let dt1 = $0.timezone ?? "0"
                let dt2 = $1.timezone ?? "0"
                return dt1 > dt2
            }
            self.historyWeatherData.value = sortedArray
        }
    }
}
