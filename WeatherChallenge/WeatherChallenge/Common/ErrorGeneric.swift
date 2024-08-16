//
//  ErrorGeneric.swift
//  WeatherChallenge
//
//  Created by Jonashio on 16/8/24.
//

import Foundation

public enum ErrorGeneric:Error {
    case general(Error)
    case empty
}
