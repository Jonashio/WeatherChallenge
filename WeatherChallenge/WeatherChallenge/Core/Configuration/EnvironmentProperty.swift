//
//  EnvironmentProperty.swift
//  WeatherChallenge
//
//  Created by Jonashio on 16/8/24.
//

import Foundation

class EnvironmentProperty {
    
    // MARK: - BASE ENDPOINTS
    static var keyUrlBase: String {
        Bundle.main.object(forInfoDictionaryKey: "KEY_URL_BASE") as? String ?? ""
    }
    
    // MARK: - BASE ENDPOINTS
    static var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "KEY_API") as? String ?? ""
    }
}
