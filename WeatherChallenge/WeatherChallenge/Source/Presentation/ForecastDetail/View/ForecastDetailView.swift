//
//  ForecastDetailView.swift
//  WeatherChallenge
//
//  Created by Jonashio on 18/8/24.
//

import SwiftUI

struct ForecastDetailView: View {
    
    var cityName: String
    var forecastHoursPerDay: [ForecastDay]
    var namespace: Namespace.ID
    var close: () -> ()
    
    @State var firstAnimationDone = false
    
    var body: some View {
        VStack {
            buildHeaderView()
            buildExtraInfoView()
                .offset(y: firstAnimationDone ? 0 : 500)
            Spacer()
        }
        .background(.black)
        .onAppear(){
            withAnimation(.easeOut(duration: 0.5)) {
                self.firstAnimationDone = true
            }
        }
    }
    
    func buildExtraInfoView() -> some View {
        ScrollView {
            ForEach(forecastHoursPerDay, id: \.dt) { forecast in
                HStack {
                    Text(Utilities.formatDayFromTimestamp(forecast.dt))
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                    Spacer()
                    Text(forecast.weather)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.white)
                }.padding(EdgeInsets(top: 20, leading: 15, bottom: 0, trailing: 15))
                
                Divider().background(.white)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(forecast.weatherDesc)
                            .font(.title3)
                            .foregroundStyle(.white)
                        
                        Text("\(forecast.humidity)% hum")
                            .font(.title3)
                            .foregroundStyle(.white)
                        
                        Text(String(format: "%.2f Wind Speed", forecast.windSpeed))
                            .font(.title3)
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(String(format: "%.2fºF", forecast.temp))
                            .font(.title3)
                            .foregroundStyle(.white)
                        Text(String(format: "Máx. %.2fºF", forecast.tempMax))
                            .font(.title3)
                            .foregroundStyle(.white)
                        Text(String(format: "Mín. %.2fºF", forecast.tempMax))
                            .font(.title3)
                            .foregroundStyle(.white)
                    }

                }
                .padding(.horizontal, 15)
            }
        }
    }
    
    func buildHeaderView() -> some View {
        ZStack {
            Image(Constants.bgCell)
                .resizable()
                .scaledToFit()
                .matchedGeometryEffect(id: "img_\(cityName)", in: namespace)
            VStack(alignment: .center) {
                Text(cityName)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .matchedGeometryEffect(id: "title_\(cityName)", in: namespace)
            }
            buildButtonClose()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 200)
        .cornerRadius(13)
    }
    
    func buildButtonClose() -> some View {
        VStack {
            Button(action: {
                withAnimation(.easeOut(duration: 0.5)) {
                    self.firstAnimationDone = false
                }
                close()
            }, label: {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .padding()
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
}

#Preview {
    ForecastDetailView(cityName: "Sabadell", forecastHoursPerDay: [.fake()], namespace: Namespace().wrappedValue, close: {})
}
