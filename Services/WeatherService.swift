//
//  WeatherService.swift
//  Weathi
//
//  Created by on 09/03/2025.
//
import Foundation

class WeatherService {
    static let shared = WeatherService()
    private let apiKey = " "
    private let baseURL = "https://api.openweathermap.org/data/"
    private var tempUnits: String {
        if UserDefaults.standard.bool(forKey: "isMetric") {
            return "imperial"
        } else {
            return "metric"
        }
    }
        
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(baseURL)2.5/weather?q=\(city)&appid=\(apiKey)&units=\(tempUnits)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data returned", code: -1)))
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weather))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    

    func fetchHistoryWeather(for city: String,
                             date: Date,
                             completion: @escaping (Result<HistoryWeatherData, Error>) -> Void)
    {
        getCoordinates(for: city) { result in
            switch result {
            case .success(let (lat, lon)):
                let timestamp = Int(date.timeIntervalSince1970)
                    let urlString = "\(self.baseURL)3.0/onecall/timemachine?lat=\(lat)&lon=\(lon)&dt=\(timestamp)&appid=\(self.apiKey)&units=\(self.tempUnits)"
                
                guard let url = URL(string: urlString) else {
                    completion(.failure(NSError(domain: "Invalid URL", code: -1)))
                    return
                }
                
                URLSession.shared.dataTask(with: url) { data, _, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(NSError(domain: "No data returned", code: -1)))
                        return
                    }
                    
                    do {
                        let historyData = try JSONDecoder().decode(HistoryWeatherData.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(historyData))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }.resume()
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    

    func getCoordinates(for city: String, completion: @escaping (Result<(Double, Double), Error>) -> Void) {
        let urlString = "\(baseURL)2.5/weather?q=\(city)&appid=\(apiKey)&units=\(tempUnits)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data returned", code: -1)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(CityCoordinateResponse.self, from: data)
                let lat = decoded.coord.lat
                let lon = decoded.coord.lon
                DispatchQueue.main.async {
                    completion(.success((lat, lon)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
