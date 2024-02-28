//
//  WeatherListViewModel.swift
//  weather_app
//
//  Created by Shaxobiddin on 23/02/24.
//

import Foundation

class WeatherListViewModel {
    private (set) var weatherData: [WeatherDataEntity] = []
    
    func updateUnit(to unit: Unit) {
        switch unit {
            case .celsius:
                toCelsium()
            case .fahrenheit:
                toFahrenheit()
        }
    }
    
    func addWeather(data: WeatherDataEntity) {
        weatherData.append(data)
    }
    
    func weatherDataLength(_ section: Int) -> Int {
        return weatherData.count
    }
    
    private func toCelsium() {
        weatherData = weatherData.map { data in
            if !data.isCelsius {
                let weather = data;
                weather.isCelsius = true
                weather.temperature = (weather.temperature - 32) * 5/9
                return weather
            }
            return data
        }
    }
    
    private func toFahrenheit() {
        weatherData = weatherData.map { data in
            if data.isCelsius {
                let weather = data;
                weather.isCelsius = false
                weather.temperature = (weather.temperature * 9/5) + 32
                return weather
            }
            return data
        }
    }
}
