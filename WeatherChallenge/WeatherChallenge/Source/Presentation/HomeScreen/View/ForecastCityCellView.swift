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
    var isSelected: Bool
    var mainAction: () -> ()
    var action: (Constants.DataDay)->()
    
    var body: some View {
        VStack {
            ZStack {
                Image(Constants.bgCell)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 100)
                    .matchedGeometryEffect(id: "img_\(city.cityName)", in: namespace)
                HStack {
                    VStack(alignment: .leading) {
                        Text(city.cityName)
                            .font(.title)
                            .bold()
                            .foregroundStyle(.white)
                            .matchedGeometryEffect(id: "title_\(city.cityName)", in: namespace)
                        Spacer()
                        Text(city.forecastDay.first?.weather ?? "-")
                            .font(.headline)
                            .bold()
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    if let mainForecast = city.forecastDay.first {
                        VStack(alignment: .trailing) {
                            Text(String(format: "%.2fºF", mainForecast.temp))
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.white)
                            Spacer()
                            HStack(spacing:20) {
                                Text(String(format: "Máx. %.2fºF", mainForecast.tempMax))
                                    .font(.caption2)
                                    .bold()
                                    .foregroundStyle(.white)

                                Text(String(format: "Mín. %.2fºF", mainForecast.tempMax))
                                    .font(.caption2)
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                        }
                    }

                }
                .padding(15)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 100)
            .cornerRadius(13)
            .shadow(color: isSelected ? .red : .white, radius: isSelected ? 6 : 4)
            .onTapGesture(perform: mainAction)
            
            if isSelected {
                SelectorDayView(action: action)
            }
        }
        .background(.clear)
        
        
    }
}

#Preview(traits: .fixedLayout(width: 400, height: 150)) {
    ForecastCityCellView(city: .fakeItem(), namespace: Namespace().wrappedValue, isSelected: true, mainAction: {}, action: { _ in })
}
