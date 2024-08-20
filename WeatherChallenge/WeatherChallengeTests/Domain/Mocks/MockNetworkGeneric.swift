//
//  MockNetworkGeneric.swift
//  WeatherChallengeTests
//
//  Created by Jonashio on 20/8/24.
//

import XCTest
@testable import WeatherChallenge

class MockNetworkGeneric: NetworkGeneric {
    var resultToReturn: Result<ForecastResponseDTO, NetworkError>?
    
    override func getData<Type>(profileEndpoint: NetworkManager, builder: ((Data) throws -> Type), keeper: ((Data) -> Void)? = nil) async -> Result<Type, NetworkError> {
        guard let result = resultToReturn as? Result<Type, NetworkError> else {
            return .failure(.unknown)
        }
        return result
    }
    
    func successLoadData() {
        let city = City(id: 3128760, name: "Barcelona", coord: .init(lat: 41.3888, lon: 2.159), country: "ES", population: 1621537, timezone: 7200, sunrise: 1724043893, sunset: 1724093118)
        let main = Main(temp: 297.39, feelsLike: 297.41, tempMin: 297.39, tempMax: 297.87, pressure: 1014, seaLevel: 1014, grndLevel: 1007, humidity: 59, tempKf: -0.48)
        let list = [ForecastDayDTO(dt: 1724058000,
                                   main: main,
                                   weather: [Weather(id: 500, main: "Rain", description: "description", icon: "10d")],
                                   clouds: Clouds(all: 75), wind: Wind(speed: 3.21, deg: 201, gust: 3.27),
                                   visibility: 10000,
                                   pop: 0.65,
                                   rain: Rain(threeHours: 0.54),
                                   dtTxt: "2024-08-19 09:00:00")]
        resultToReturn = .success(.init(cod: "200", message: 0, cnt: 40, list: list, city: city))

    }
    
    func errorLoadData() {
        resultToReturn = .failure(.unknown)
    }
}
