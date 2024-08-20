//
//  HomeScreen.swift
//  WeatherChallenge
//
//  Created by Jonashio on 15/8/24.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
    @Environment(HomeScreenViewModel.self) private var vm
    @Environment(\.modelContext) var modelContext
    @State private var searchText = ""
    @Namespace var namespace
    
    var body: some View {
        
        ZStack {
            VStack {
                buildHeader()
                buildListCities()
                buildFooter()
            }
            
            if let cityName = vm.citySelected?.cityName,
               let forecast = vm.daysSelected {
                ForecastDetailView(cityName: cityName, forecastHoursPerDay: forecast, namespace: namespace, close: vm.unSelectDay)
            }
        }
        .background(.black)
        .onAppear(){
            vm.fetchAllSaved(modelContext)
        }

    }
    
    func buildHeader() -> some View {
        HStack{
            TextEditor(text: $searchText)
                .lineLimit(1)

            Button(action: {
                Task{ await vm.fetchData(searchText: searchText)}
            }, label: {
                Text("Add")
            })
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .padding(.horizontal)
    }
    
    func buildListCities() -> some View {
        List{
            ForEach(vm.cities, id: \.id) { city in

                ForecastCityCellView(city: city,
                                     namespace: namespace,
                                     isSelected: vm.citySelected?.id == city.id,
                                     mainAction: { vm.doSelectCity(city) }, action: { vm.doSelectDay($0) })
                .listRowBackground(Color.black)
            }
            .onDelete(perform: vm.doRemove)
        }
        .listStyle(.plain)
        .background(.clear)
    }
    
    func buildFooter() -> some View {
        Text("Cities added \(vm.cities.count)")
            .font(.title3)
    }
}

#Preview {
    HomeScreen()
        .modelContainer(try! ModelContainer(for: CityPersistenceModel.self))
        .environment(HomeScreenViewModel(useCase: GetForecastUseCase()))
}
