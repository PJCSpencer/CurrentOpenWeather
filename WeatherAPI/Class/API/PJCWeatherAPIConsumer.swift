//
//  PJCWeatherAPIConsumer.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


class PJCWeatherAPIConsumer
{
    // MARK: - Property(s)
    
    private(set) var task: URLSessionTask!
    
    fileprivate var completion: PJCWeatherAPIResponseHandler!
    
    
    // MARK: - Initialisation
    
    init(_ provider: PJCDataTaskProvider,
         request: URLRequest,
         completion: @escaping PJCWeatherAPIResponseHandler)
    {
        self.task = provider.task(for: request,
                                  responseHandler: self.responseHandler)
        self.completion = completion
    }
    
    deinit
    {
        if self.task.state != .completed
        {
            self.task.cancel()
            
            DispatchQueue.main.async()
            { self.completion(.failure(PJCAPIError.canceled)) }
        }
    }
}

// MARK: - PJCResponseHandlerProvider
extension PJCWeatherAPIConsumer: PJCResponseHandlerProvider
{
    func responseHandler(forStatus code: Int) -> PJCDataTaskResponseHandler?
    {
        let table: [Int:PJCDataTaskResponseHandler] = [PJCServiceError.success.statusCode : self.serialise]
        
        return table[code]
    }
}

// MARK: - URL Response Consumer Method(s)
extension PJCWeatherAPIConsumer
{
    func serialise(_ result: PJCDataTaskResult)
    {
        guard let result: PJCCurrentWeather = try? result.get().decodedJSON() else
        {
            DispatchQueue.main.async()
            { self.completion(.failure(PJCAPIError.failed)) }
            return
        }
        
        DispatchQueue.main.async()
        { self.completion(.success(PJCAPIDataResponse([result]))) }
    }
}

