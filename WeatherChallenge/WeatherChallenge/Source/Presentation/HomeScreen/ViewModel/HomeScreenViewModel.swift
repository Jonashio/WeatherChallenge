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
    var daysSelected: [ForecastDay]?
    
    // MARK: - Private Properties
    private let useCase: GetForecastUseCase
    
    
    init(useCase: GetForecastUseCase) {
        self.useCase = useCase
    }
    
    func doSelectDay(_ day: Constants.DataDay) {
        guard let selected = citySelected else { return }
        guard let selectedDate = Utilities.dateFromTimestamp(day.dat) else { return }

        let calendar = Calendar.current
        withAnimation {
            daysSelected = selected.forecastDay.filter { forecastDay in
                if let date = Utilities.dateFromTimestamp("\(forecastDay.dt)") {
                    return calendar.isDate(date, inSameDayAs: selectedDate)
                }
                return false
            }
        }
    }
    
    func unSelectDay() {
        withAnimation { daysSelected = nil }
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
    
    func doSelectCity(_ city: ForescastResumenCity?) {
        withAnimation {
            (citySelected?.id == city?.id) ? (citySelected = nil) : (citySelected = city)
            daysSelected = nil
        }
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
