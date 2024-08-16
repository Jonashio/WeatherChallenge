//
//  CityPersistenceModel.swift
//  WeatherChallenge
//
//  Created by Jonashio on 16/8/24.
//

import SwiftData

@Model
class CityPersistenceModel {
    @Attribute(.unique) let id: String
    let city: String
    
    init(id: String,
         city: String) {
        self.id = id
        self.city = city
    }
    
    static func builder(_ model: ForescastResumenCity) -> CityPersistenceModel {
        CityPersistenceModel(id: model.id.uuidString,
                             city: model.cityName)
    }
}
