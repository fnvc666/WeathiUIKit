//
//  WeatherData.swift
//  Weathi
//
//  Created by on 09/03/2025.
//
import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind?
    let rain: Rain?
    let dt: TimeInterval
    let timezone: Int 
    
    struct Main: Codable {
        let temp: Double
        let humidity: Int
    }
    
    struct Weather: Codable {
        let id: Int
        let description: String
    }
    
    struct Wind: Codable {
        let speed: Double
    }
    
    struct Rain: Codable {
        let lastHour: Double?
        
        enum CodingKeys: String, CodingKey {
            case lastHour = "1h"
        }
    }
}
