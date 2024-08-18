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
        VStack {
            HStack{
                TextEditor(text: $searchText)
                    .lineLimit(1)

                Button(action: {
                    Task{ await vm.fetchData(searchText: searchText)}
                }, label: {
                    Text("Add")
                })
            }.frame(maxWidth: .infinity, maxHeight: 40)
            List{
                VStack{
                    ForEach(vm.cities, id: \.id) { city in
                        
                        ForecastCityCellView(city: city, namespace: namespace){
                            vm.doSelectUser(city)
                        }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                    }
                    .onDelete(perform: vm.doRemove)
                }
            }
            .listStyle(.plain)
            .background()
            .padding(.top, 1)
            .ignoresSafeArea(edges: .top)
            
            Text("Hello, world! \(vm.cities.count)")
            Spacer()
        }
        .padding()
        .onAppear(){
            vm.context = modelContext
        }
    }
}

#Preview {
    HomeScreen()
        .modelContainer(try! ModelContainer(for: CityPersistenceModel.self))
        .environment(HomeScreenViewModel(useCase: GetForecastUseCase()))
}
