//
//  HomeScreenViewModel.swift
//  WeatherChallenge
//
//  Created by Jonashio on 16/8/24.
//

import SwiftUI
import SwiftData

@Observable class HomeScreenViewModel {
    
    // MARK: - Properties
    var cities: [ForescastResumenCity] = []
    var status: Status = .idle
    var context: ModelContext?
    var citySelected: ForescastResumenCity?
    
    // MARK: - Private Properties
    private let useCase: GetForecastUseCase
    
    
    init(useCase: GetForecastUseCase) {
        self.useCase = useCase
    }
    
    func fetchData(searchText: String) async {
        status = .loading
        
        let response = await useCase.execute(parameters: buildParamsDTO(searchQuery: searchText))
        
        switch response {
        case .success(let model):
            updateViewData(newCities: model)
        default:
            status = .error
        }
    }
    
    func fetchAllSaved(_ context: ModelContext) {
        self.context = context
        let listCity: [String] = CityPersistenceManager.shared.getCities(context).map({ $0.city })
        cities.removeAll()
        
        for city in listCity {
            Task { await fetchData(searchText: city)}
        }
    }
    
    func doRemove(_ indexSet: IndexSet) {
        guard let context = context else { return }
        guard let cityToDelete = (indexSet.map { self.cities[$0] }).first else { return }
        
        _ = CityPersistenceManager.shared.removeCity(cityToDelete, context: context)
        
        withAnimation { cities.remove(atOffsets: indexSet) }
        
    }
    
    func doSelectUser(_ city: ForescastResumenCity?) {
        withAnimation { citySelected = city }
    }
}

extension HomeScreenViewModel {
    
    private func updateViewData(newCities: ForescastResumenCity) {
        guard let context = context else { return }
        
        _ = CityPersistenceManager.shared.addCity(newCities, context: context)
        
        withAnimation {
            cities.removeAll(where: { $0.cityName.elementsEqual(newCities.cityName) })
            cities.append(newCities)
            status = .idle
        }
    }
    
    private func buildParamsDTO(searchQuery: String) -> ForecastRequestDTO {
        ForecastRequestDTO(q: searchQuery)
    }
    
}
