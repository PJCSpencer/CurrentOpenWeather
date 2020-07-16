//
//  UIKit+Additions.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import UIKit


// MARK: - Protocol
protocol PJCGeometryLayout
{
    func updateLayout(_ container: UIView?)
}

protocol PJCGeometry
{
    static var fixedSize: CGSize { get }
}

protocol PJCDynamicGeometry
{
    func calculatedSize() -> CGSize
}

// MARK: - UIColor
extension UIColor
{
    // http://www.tannerhelland.com/4435/convert-temperature-rgb-algorithm-code
    
    static func color(measurement: Measurement<UnitTemperature>) -> UIColor
    {
        let red = UIColor.red(measurement: measurement)
        let green = UIColor.green(measurement: measurement)
        let blue = UIColor.blue(measurement: measurement)
        
        return UIColor(red: red / 255,
                       green: green / 255,
                       blue: blue / 255,
                       alpha: 1.0)
    }
    
    static func red(measurement: Measurement<UnitTemperature>) -> CGFloat
    {
        var result = 255.0
        
        if measurement.value > 66
        {
            result = measurement.value - 60.0
            result = 329.698727466 * pow(result, -0.1332047592)
        }
        return CGFloat.clamped(value: CGFloat(result))
    }
    
    static func green(measurement: Measurement<UnitTemperature>) -> CGFloat
    {
        var result = 255.0
        
        if measurement.value <= 66
        {
            result = measurement.value
            result = (99.4708025861 * log(result)) - 161.1195681661
        }
        else
        {
            result = measurement.value - 60
            result = 288.1221695283 * pow(result, -0.0755148492)
        }
        return CGFloat.clamped(value: CGFloat(result))
    }
    
    static func blue(measurement: Measurement<UnitTemperature>) -> CGFloat
    {
        var result = 255.0
        
        if measurement.value < 65
        {
            if measurement.value <= 19
            {
                result = 0
            }
            else
            {
                result = measurement.value - 10
                result = (138.5177312231 * log(result)) - 305.0447927307
            }
        }
        return CGFloat.clamped(value: CGFloat(result))
    }
}

// MARK: - CGFloat
extension CGFloat
{
    static func clamped(value: CGFloat) -> CGFloat
    { return value > 255 ? 255 : (value < 0 ? 0 : value) }
}

