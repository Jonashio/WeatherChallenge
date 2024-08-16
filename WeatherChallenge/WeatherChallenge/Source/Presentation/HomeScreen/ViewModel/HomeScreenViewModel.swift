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
    var searchText: String = ""
    
    // MARK: - Private Properties
    private let useCase: GetForecastUseCase
    
    
    init(useCase: GetForecastUseCase) {
        self.useCase = useCase
    }

    @Sendable func fetchData() async {
        status = .loading
        
        let response = await useCase.execute(parameters: buildParamsDTO())
        
        switch response {
        case .success(let model):
            updateViewData(newCities: model)
        default:
            status = .error
        }
    }
    
    func loadSavedData(_ context: ModelContext) {
        self.context = context
        withAnimation {
            cities = CityPersistenceManager.shared.getCities(context).map({ ForescastResumenCity.builder($0) })
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
            cities.append(newCities)
            status = .idle
        }
    }
    
    private func buildParamsDTO() -> ForecastRequestDTO {
        ForecastRequestDTO(q: searchText)
    }
    
}
