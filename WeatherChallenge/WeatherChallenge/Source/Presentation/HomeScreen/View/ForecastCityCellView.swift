//
//  ForecastCityCellView.swift
//  WeatherChallenge
//
//  Created by Jonashio on 17/8/24.
//

import SwiftUI

struct ForecastCityCellView: View {
    
    var city: ForescastResumenCity
    var namespace: Namespace.ID
    var action: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(city.cityName)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    Spacer()
                    Text(city.weatherDesc)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(String(format: "%.2fºF", city.temp))
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                    Spacer()
                    HStack(spacing:20) {
                        Text(String(format: "Máx. %.2fºF", city.tempMax))
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.white)

                        Text(String(format: "Mín. %.2fºF", city.tempMax))
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(15)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 110)
        .background{
            Image("bg-cell")
                .resizable()
                .scaledToFill()
                .frame(height: 110)
                .cornerRadius(16)
                
        }
    }
}

#Preview {
    ForecastCityCellView(city: .fakeItem(), namespace: Namespace().wrappedValue, action: {})
}
