//
//  WeatherDataEntity.swift
//  weather_app
//
//  Created by Shaxobiddin on 27/02/24.
//
//

import Foundation
import SwiftData


@Model public class WeatherDataEntity {
    var name: String?
    var temperature: Double? = 0.0
    var isCelsius: Bool?
    public init() {

    }
    
}
