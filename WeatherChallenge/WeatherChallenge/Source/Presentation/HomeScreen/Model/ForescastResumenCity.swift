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
    let forecastDay: [ForecastDay]
    
    
    static func fakeItem() -> Self {
        ForescastResumenCity(id: UUID(),
                             cityName: "Spain",
                             forecastDay: [.fake()])
    }
    
    static func builder(_ model: CityPersistenceModel) -> Self {
        ForescastResumenCity(id: UUID(),
                             cityName: model.city,
                             forecastDay: [])
    }
    
    static func builder(_ model: ForecastResponseDTO) -> Self {
        ForescastResumenCity(id: UUID(),
                             cityName: model.city.name,
                             forecastDay: model.list.compactMap({ .builder($0) }))
    }
}

struct ForecastDay {
    let dt: Int
    let windSpeed: Double
    let humidity: Int
    let weather: String
    let weatherDesc: String
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let icon: String
    
    static func fake() -> ForecastDay {
        ForecastDay(dt: Int(Date().timeIntervalSince1970), windSpeed: 9.0, humidity: 15, weather: "Nublado", weatherDesc: "Chubascos ligeros", temp: 278.93, tempMin: 275.93, tempMax: 280.93, icon: "10d")
    }
    
    static func builder(_ model: ForecastDayDTO) -> Self {
        ForecastDay(dt: model.dt,
                    windSpeed: model.wind.speed,
                    humidity: model.main.humidity,
                    weather: model.weather.first?.main ?? "-",
                    weatherDesc: model.weather.first?.description ?? "-",
                    temp: model.main.temp,
                    tempMin: model.main.tempMin,
                    tempMax: model.main.tempMax,
                    icon: model.weather.first?.icon ?? "-")
    }
}
