//
//  PJCEnvironment.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


enum PJCHost: String
{
    case api = "api.openweathermap.org"
    
    var scheme: HTTPScheme
    { return .https }
}

enum PJCEnvironment
{
    case develop
    
    
    // MARK: - Returning the Current Environment
    
    static var current: PJCEnvironment
    { return .develop }
    
    
    // MARK: - Returning the Host
    
    static var host: PJCHost
    {
        switch PJCEnvironment.current
        {
        case .develop: return .api
        }
    }
}

