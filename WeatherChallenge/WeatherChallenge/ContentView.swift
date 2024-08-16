//
//  ContentView.swift
//  WeatherChallenge
//
//  Created by Jonashio on 15/8/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(HomeScreenViewModel.self) private var vm
    @Environment(\.modelContext) var modelContext
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            HStack{
                TextEditor(text: $searchText)
                    .lineLimit(1)

                Button(action: {
                    Task{ await vm.fetchData() }
                }, label: {
                    Text("Add")
                })
            }.frame(maxWidth: .infinity, maxHeight: 40)
            

            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world! \(vm.cities.count)")
            Spacer()
        }
        .padding()
        .onChange(of: searchText) { _, _ in
            vm.searchText = searchText
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(try! ModelContainer(for: CityPersistenceModel.self))
        .environment(HomeScreenViewModel(useCase: GetForecastUseCase()))
}
