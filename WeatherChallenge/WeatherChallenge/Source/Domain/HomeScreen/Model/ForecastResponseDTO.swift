//
//  ForecastResponseDTO.swift
//  WeatherChallenge
//
//  Created by Jonashio on 16/8/24.
//

import Foundation

// MARK: - ForecastResponseDTO
struct ForecastResponseDTO: Codable {
    let cod: String
    let message, cnt: Int
    let list: [ForecastDay]
    let city: City
    
    static func builder() -> ((Data) throws -> ForecastResponseDTO) {
        { data in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            
            return try decoder.decode(ForecastResponseDTO.self, from: data)
        }
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}
