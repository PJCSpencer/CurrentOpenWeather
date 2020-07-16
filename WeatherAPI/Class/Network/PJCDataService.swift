//
//  PJCDataService.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


typealias PJCDataTaskResult = Result<PJCTaskData, Error>

typealias PJCDataTaskResponseHandler = (PJCDataTaskResult) -> Void

typealias PJCDataTaskResponseHandlerProvider = (_ statusCode: Int) -> PJCDataTaskResponseHandler?

protocol PJCDataTaskProvider
{
    func task(for request: URLRequest,
              responseHandler: @escaping PJCDataTaskResponseHandlerProvider) -> URLSessionTask
}

protocol PJCResponseHandlerProvider
{
    func responseHandler(forStatus code: Int) -> PJCDataTaskResponseHandler?
}

// MARK: - PJCTaskData
struct PJCTaskData
{
    let data: Data
    
    let type: ContentType
}

extension PJCTaskData
{
    func decodedJSON<T:Codable>() -> T?
    {
        guard self.type == ContentType(MIMETypeApplication.json),
            let result = try? JSONDecoder().decode(T.self, from: self.data) else
        { return nil }
        
        return result
    }
}

// MARK: - PJCDataService
class PJCDataService
{
    // MARK: - Property(s)
    
    private(set) var session: URLSession = URLSession.shared
    
    
    // MARK: - Initialisation
    
    init(session: URLSession? = nil)
    { self.session = session ?? URLSession.shared }
}

extension PJCDataService: PJCDataTaskProvider
{
    func task(for request: URLRequest,
              responseHandler: @escaping PJCDataTaskResponseHandlerProvider) -> URLSessionTask
    {
        return self.session.dataTask(with: request)
        { (data, response, error) in
            
            guard error == nil,
                let response = response as? HTTPURLResponse else
            { return }
            
            let statusCode = response.statusCode
            guard let handler = responseHandler(statusCode) as PJCDataTaskResponseHandler? else
            { return }
            
            let serviceError = PJCServiceError.status(statusCode)
            guard let contentType = response.allHeaderFields[HTTPHeaderField.contentType.rawValue] as? String,
                let data = data  else
            {
                handler(.failure(serviceError))
                return
            }
            
            guard let type = ContentType(contentType) else
            {
                handler(.failure(PJCServiceError.unkownData))
                return
            }
            
            let result = PJCTaskData(data: data, type: type)
            handler(.success(result))
        }
    }
}

