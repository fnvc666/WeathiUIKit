//
//  CityCoordinateResponse.swift
//  Weathi
//
//  Created by on 14/03/2025.
//
struct CityCoordinateResponse: Decodable {
    let coord: Coord
    
    struct Coord: Decodable {
        let lat: Double
        let lon: Double
    }
}
