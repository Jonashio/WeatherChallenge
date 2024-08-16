//
//  NetworkManager.swift
//  WeatherChallenge
//
//  Created by Jonashio on 15/8/24.
//

import Foundation

enum HTTPmethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkManager {
    // MARK: - Definition Services
    case forecast(ForecastRequestDTO)
    
    // MARK: - Configuration
    var scheme: String {
        Constants.scheme_https_default
    }
    
    var urlBase: String {
        switch self {
        case .forecast:
            return EnvironmentProperty.keyUrlBase
        }
    }
    
    var path: String {
        return "/forecast"
    }
    
    var method: HTTPmethod {
        switch self {
        case .forecast:
            return .get
        }
    }
    
    var parametersBody: Data? {
        return nil
    }
    
    var parametersPath: String {
        switch self {
        case .forecast(let requestModel):
            guard let params = codableToParamURL(model: requestModel), !params.isEmpty else { return "" }
            return "?" + params
        }
    }
    
    var contentType: String {
        switch self {
        case .forecast:
            return ""
        }
    }
    
    var accept: String {
        switch self {
        case .forecast:
            return "application/json;charset=utf8"
        }
    }
    
    private func codableToParamURL(model: Codable) -> String? {
        guard let data = try? JSONEncoder().encode(model) else { return nil }
        guard let dictionary = ((try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }) else { return nil }
        
        let result = dictionary.compactMap { key, value in return "\(key)=\(value)" }
            .joined(separator: "&")
            .toFormatURL
        return result
    }
}
