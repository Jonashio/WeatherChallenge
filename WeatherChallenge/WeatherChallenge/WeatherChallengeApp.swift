//
//  WeatherChallengeApp.swift
//  WeatherChallenge
//
//  Created by Jonashio on 15/8/24.
//

import SwiftUI
import SwiftData

@main
struct WeatherChallengeApp: App {
    @State private var dashboVM = HomeScreenViewModel(useCase: GetForecastUseCase()) //Se podria crear un assembler para la instancia de esto
    @State var isFinishedSplash = false
    let modelContainer: ModelContainer
    
    init() {
        var inMemory = false

        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            inMemory = true
        }
        #endif
        
        do {
            let config = ModelConfiguration(for: CityPersistenceModel.self, isStoredInMemoryOnly: inMemory)
            modelContainer = try ModelContainer(for: CityPersistenceModel.self, configurations: config)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(dashboVM)
        }
        .modelContainer(modelContainer)
    }
}
