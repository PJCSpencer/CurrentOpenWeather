//
//  PJCAPI.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


enum PJCAPIKey: String
{
    case appid
    case query = "q"
    case units
}

enum PJCAPISecurityKey: String
{
    case appid = "copyAPIKeyHere"
}

enum PJCAPIError: Error
{
    case none
    case failed, canceled
    case unknown
}

// MARK: - Protocol(s)
protocol PJCAPIPathComponent // TODO:Support version, type, etc ..?
{
    static var relativePath: String { get }
}

// MARK: - PJCAPIRequest
struct PJCAPIRequest
{
    let path: String
    
    let queryItems: [URLQueryItem]
    
    
    // MARK: - Initialisation
    
    init(_ path: String,
         queryItems: [URLQueryItem]? = nil)
    {
        self.path = path
        self.queryItems = queryItems ?? []
    }
}

extension PJCAPIRequest: PJCURLRequestProvider
{
    func urlRequest(_ parameters: PJCURLRequestParameters) -> URLRequest?
    { return URLComponents.from(self).urlRequest(parameters) }
}

// MARK: - PJCGenericAPIRequest
struct PJCGenericAPIRequest<T: PJCAPIPathComponent>
{
    let type: T.Type
    
    let queryItems: [URLQueryItem]
    
    
    // MARK: - Initialisation
    
    init(_ type: T.Type,
         queryItems: [URLQueryItem] = [])
    {
        self.type = type
        self.queryItems = queryItems
    }
}

extension PJCGenericAPIRequest: PJCURLRequestProvider
{
    func urlRequest(_ parameters: PJCURLRequestParameters) -> URLRequest?
    { return URLComponents.from(self).urlRequest(parameters) }
}

// MARK: - PJCAPIResponse
struct PJCAPIResponse<T> // NB:The following response struct names should be swapped.
{
    let data: PJCAPIDataResponse<T>?
    
    let error: Error?
}

struct PJCAPIDataResponse<T>
{
    // MARK: - Property(s)
    
    let objects: [T]
    
    let indexPaths: [IndexPath]
    
    
    // MARK: - Initialiser(s)
    
    init(_ objects: [T]? = nil,
         indexPaths: [IndexPath]? = nil)
    {
        self.objects = objects ?? []
        self.indexPaths = indexPaths ?? []
    }
}

