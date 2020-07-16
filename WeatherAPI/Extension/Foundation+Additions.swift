//
//  Foundation+Additions.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import Foundation


extension Int
{
    func megabytes() -> Int
    { return self * 1024 * 1024 }
}

extension Dictionary
{
    static func + (lhs: [Key:Value],
                   rhs: [Key:Value]) -> [Key:Value]
    {
        return lhs.merging(rhs) {$1}
    }
}

