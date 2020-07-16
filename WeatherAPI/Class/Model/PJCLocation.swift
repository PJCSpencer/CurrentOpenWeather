//
//  PJCLocation.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation
import CoreLocation


// MARK: - PJCLocation
enum PJCLocation: String // TODO:Expand, consider an alternative domain name ...
{
    case london
}

// MARK: - PJCCoordinates
struct PJCCoordinates: Codable
{
    let lon: Double
    
    let lat: Double
}

extension PJCCoordinates
{
    var location: CLLocation
    { return CLLocation(latitude: self.lat, longitude: self.lon) }
    
    var locationCoordinates2D: CLLocationCoordinate2D
    {
        return CLLocationCoordinate2D(latitude: self.lat,
                                      longitude: self.lon)
    }
    
    func city(completion: @escaping (Result<String, Error>) -> Void)
    {
        CLGeocoder().reverseGeocodeLocation(self.location)
        { (placemarks, error) in
            
            guard let placemark = placemarks?.first,
                let isoCountryCode = placemark.isoCountryCode,
                let locality = placemark.locality else
            {
                completion(.failure(error ?? PJCAPIError.unknown))
                return
            }
            completion(.success("\(locality), \(isoCountryCode)"))
        }
    }
}

