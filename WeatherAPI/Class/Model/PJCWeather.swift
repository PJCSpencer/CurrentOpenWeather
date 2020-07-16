//
//  PJCWeather.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


enum PJCWeatherKey: String
{
    case clouds
    case thunderstorm
    case drizzle
    case rain
    case snow
    case clear
    case mist
}

// MARK: - PJCCurrentWeather
struct PJCCurrentWeather: Codable
{
    let coord: PJCCoordinates
    
    let weather: [PJCWeather]
    
    let main: PJCMain
    
    let wind: PJCWind
    
    let clouds: PJCClouds
    
    let sys: PJCSys
    
    let name: String
}

// MARK: - PJCWeather
struct PJCWeather: Codable
{
    let id: Int
    
    let main: String
    
    let description: String
    
    let icon: String
}

// MARK: - PJCMain
struct PJCMain: Codable
{
    let temp: Double
    
    let pressure: Int
    
    let humidity: Int
    
    let temp_min: Double
    
    let temp_max: Double
}

// MARK: - PJCClouds
struct PJCClouds: Codable
{
    let all: Int
}

// MARK: - PJCWind
struct PJCWind: Codable
{
    let speed: Double
    
    let deg: Int
}

struct PJCSys: Codable // Maybe System parameter?
{
    let country: String
}

