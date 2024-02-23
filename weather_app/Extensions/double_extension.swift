//
//  double_extension.swift
//  weather_app
//
//  Created by Shaxobiddin on 23/02/24.
//

import Foundation

extension Double {
    var formatTemp: String {
        return String(format: "%.0f", self)
    }
}
