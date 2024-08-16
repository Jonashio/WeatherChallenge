//
//  ForescastResumenCity.swift
//  WeatherChallenge
//
//  Created by Jonashio on 16/8/24.
//

import Foundation

struct ForescastResumenCity: Identifiable {
    let id: UUID
    let cityName: String
    let weatherDesc: String
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let icon: String
    
    
    static func fakeItem() -> Self {
        ForescastResumenCity(id: UUID(),
                             cityName: "Spain",
                             weatherDesc: "Rain",
                             temp: 286.94,
                             tempMin: 286.94,
                             tempMax: 287.43,
                             icon: "10n")
    }
    
    static func builder(_ model: CityPersistenceModel) -> Self {
        ForescastResumenCity(id: UUID(),
                             cityName: model.city,
                             weatherDesc: "",
                             temp: 0.00,
                             tempMin: 0.00,
                             tempMax: 0.00,
                             icon: "")
    }
    
    static func builder(_ model: ForecastResponseDTO) -> Self {
        ForescastResumenCity(id: UUID(),
                             cityName: model.city.name,
                             weatherDesc: model.list.first?.weather.first?.main ?? "-",
                             temp: model.list.first?.main.temp ?? 0.00,
                             tempMin: model.list.first?.main.tempMin ?? 0.00,
                             tempMax: model.list.first?.main.tempMax ?? 0.00,
                             icon: model.list.first?.weather.first?.icon ?? "-")
    }
}
