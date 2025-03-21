//
//  HistoryWeatherData.swift
//  Weathi
//
//  Created by on 13/03/2025.
//
import Foundation

struct HistoryWeatherData: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String?
    let timezone_offset: Int?
    let data: [HourlyWeatherData]?
    

    struct HourlyWeatherData: Decodable {
        let dt: Int
        let temp: Double
        let weather: [Weather]
    }

    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    enum CodingKeys: String, CodingKey {
            case lat
            case lon
            case timezone
            case timezone_offset
            case data = "data" 
        }
}
