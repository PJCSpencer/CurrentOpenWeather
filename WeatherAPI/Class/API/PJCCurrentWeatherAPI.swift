//
//  PJCWeatherAPI.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


typealias PJCWeatherAPIResult = Result<PJCAPIDataResponse<PJCCurrentWeather>, Error>

typealias PJCWeatherAPIResponseHandler = (PJCWeatherAPIResult) -> Void

protocol PJCWeatherAPIRequestDelegate // TODO:Expand to support other parameter type(s) ...
{
    func request(for location: PJCLocation,
                 completion: @escaping PJCWeatherAPIResponseHandler)
}

class PJCCurrentWeatherAPI
{
    // MARK: - Property(s)
    
    private(set) var provider: PJCDataTaskProvider
    
    private(set) var consumer: PJCWeatherAPIConsumer?
    {
        didSet
        { consumer?.task.resume() }
    }
    
    
    // MARK: - Initialisation
    
    init<T:PJCDataTaskProvider>(_ provider: T)
    { self.provider = provider }
}

// MARK: - PJCAPIPathComponent
extension PJCCurrentWeatherAPI: PJCAPIPathComponent
{
    static var relativePath: String
    { return "/data/2.5/weather" }
}

// MARK: - PJCWeatherAPIRequestDelegate
extension PJCCurrentWeatherAPI: PJCWeatherAPIRequestDelegate
{
    func request(for location: PJCLocation,
                 completion: @escaping PJCWeatherAPIResponseHandler)
    {
        let city = URLQueryItem(name: PJCAPIKey.query.rawValue,
                                value: location.rawValue)
        
        let appid = URLQueryItem(name: PJCAPIKey.appid.rawValue,
                                 value: PJCAPISecurityKey.appid.rawValue)
        
        let apiRequest = PJCAPIRequest(PJCCurrentWeatherAPI.relativePath,
                                       queryItems: [city, appid])
        
        guard let urlRequest = apiRequest.urlRequest(PJCURLRequestParameters()) else
        {
            completion(.failure(PJCServiceError.badRequest))
            return
        }
        
        self.consumer = PJCWeatherAPIConsumer(self.provider,
                                              request: urlRequest,
                                              completion: completion)
    }
}

