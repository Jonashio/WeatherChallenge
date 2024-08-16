//
//  String+Extension.swift
//  WeatherChallenge
//
//  Created by Jonashio on 16/8/24.
//

import Foundation

extension String: Identifiable {
    public var id: String {
        return self
    }
    
    var toFormatURL: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)?.replacingOccurrences(of: "+", with: "%2B") ?? replacingOccurrences(of: "+", with: "%2B")
    }
}
