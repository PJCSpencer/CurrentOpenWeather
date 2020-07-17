//
//  PJCWeatherViewModel.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 15/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import UIKit


class PJCWeatherViewModel: PJCViewModel<PJCCurrentWeather>
{
    // MARK: - Constant(s)
    
    private static var dateFormatter: DateFormatter =
    {
        let anObject = DateFormatter()
        anObject.locale = Locale.current
        anObject.dateFormat = "EEEE MMMM dd, HH:mm"
        
        return anObject
    }()
    
    private static var measurementFormatter: MeasurementFormatter =
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter = numberFormatter
        measurementFormatter.locale = Locale.current
        
        return measurementFormatter
    }()
    
    
    // MARK: - Property(s)
    
    private var tempuratureMeasurement: Measurement<UnitTemperature>
    {
        return Measurement(value: self.model.main.temp,
                           unit: UnitTemperature.kelvin)
    }
    
    var color: UIColor
    { return UIColor.color(measurement: self.tempuratureMeasurement) }
    
    var request: URLRequest?
    {
        guard let key = self.model.weather.first?.main.lowercased(),
            let resource = PJCWeatherResourceTable[key] else
        { return nil }
        
        guard let url = Bundle.main.url(forResource: resource,
                                        withExtension: MIMETypeImage.svg.rawValue) else
        { return nil }
        
        return URLRequest(url: url)
    }
    
    var tempurature: String
    { return PJCWeatherViewModel.measurementFormatter.string(from: self.tempuratureMeasurement) }
    
    var location: String
    { return "\(self.model.name), \(self.model.sys.country)" }
    
    var date: String
    { return PJCWeatherViewModel.dateFormatter.string(from: Date()) }
}

