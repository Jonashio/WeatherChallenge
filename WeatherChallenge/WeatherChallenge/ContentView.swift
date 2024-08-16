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
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .modelContainer(try! ModelContainer(for: CityPersistenceModel.self))
        .environment(HomeScreenViewModel(useCase: GetForecastUseCase()))
}
