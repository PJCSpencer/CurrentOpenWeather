//
//  PJCOAuthService.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


enum AuthenticationScheme: String
{
    case basic  = "Basic"
    case bearer = "Bearer"
    case custom
}
