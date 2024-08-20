//
//  Utilities.swift
//  WeatherChallenge
//
//  Created by Jonashio on 19/8/24.
//

import Foundation

struct Utilities {
    
    static func generateNextFiveDays() -> [Constants.DataDay] {

        var daysArray: [Constants.DataDay] = []
        
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"

        let today = Date()

        for i in 0..<5 {
            if let nextDate = calendar.date(byAdding: .day, value: i, to: today) {
                let dayName: String
                if i == 0 {
                    dayName = "Today"
                } else {
                    let abbreviatedDayName = dateFormatter.string(from: nextDate)
                    dayName = String(abbreviatedDayName.prefix(3))
                }
                
                let timestamp = Int(nextDate.timeIntervalSince1970)
                
                let dayInfo: Constants.DataDay = .init(dayName: dayName, dat: "\(timestamp)")
                
                daysArray.append(dayInfo)
            }
        }
        
        return daysArray
    }
    
    static func formatDayFromTimestamp(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E h:mm a"
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    static func dateFromTimestamp(_ timestamp: String) -> Date? {
        if let timeInterval = TimeInterval(timestamp) {
            return Date(timeIntervalSince1970: timeInterval)
        }
        return nil
    }
}
