//
//  SelectorDayView.swift
//  WeatherChallenge
//
//  Created by Jonashio on 19/8/24.
//

import SwiftUI

struct SelectorDayView: View {
    let days = Utilities.generateNextFiveDays()
    var action: (Constants.DataDay)->()
    
    var body: some View {
        HStack(spacing: 3) {
            ForEach(days, id: \.dat) { day in
                ZStack{
                    Text(day.dayName)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(2)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 50)
                .background(.black)
                .cornerRadius(10)
                .onTapGesture {
                    action(day)
                }
            }
        }.frame(maxWidth: .infinity)
    }
}

#Preview(traits: .fixedLayout(width: 400, height: 100)) {
    SelectorDayView(action: { _ in })
}
