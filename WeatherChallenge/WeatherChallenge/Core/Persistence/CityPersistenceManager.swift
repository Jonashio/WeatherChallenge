//
//  CityPersistenceManager.swift
//  WeatherChallenge
//
//  Created by Jonashio on 16/8/24.
//

import SwiftData
import SwiftUI

final class CityPersistenceManager {
    static let shared = CityPersistenceManager()

    private init(){}
    
    func getCities(_ context: ModelContext) -> [CityPersistenceModel] {
        do {
            let descriptor = FetchDescriptor<CityPersistenceModel>(sortBy: [SortDescriptor(\.city)])
            return try context.fetch(descriptor)
        } catch {
            return []
        }
    }
    
    func addCity(_ city: ForescastResumenCity, context: ModelContext) -> Bool {
        context.insert(CityPersistenceModel.builder(city))
        return save(context)
    }
    
    func removeCity(_ city: ForescastResumenCity, context: ModelContext) -> Bool {
        guard let internalUser = getCities(context).first(where: { $0.city.elementsEqual(city.cityName)}) else { return false }
        context.delete(internalUser)
        return save(context)
    }
    
    private func save(_ context: ModelContext) -> Bool {
        do{
            try context.save()
            return true
        }catch{ return false }
    }
}
