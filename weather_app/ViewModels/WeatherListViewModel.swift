//
//  WeatherListViewModel.swift
//  weather_app
//
//  Created by Shaxobiddin on 23/02/24.
//

import Foundation

class WeatherListViewModel {
    private (set) var weatherData: [WeatherData] = []
    
    func updateUnit(to unit: Unit) {
        switch unit {
            case .celsius:
                toCelsium()
            case .fahrenheit:
                toFahrenheit()
        }
    }
    
    func addWeather(data: WeatherData) {
        weatherData.append(data)
    }
    
    func weatherDataLength(_ section: Int) -> Int {
        return weatherData.count
    }
    
    private func toCelsium() {
        weatherData = weatherData.map { data in
            if data.unit != .celsius {
                var weather = data;
                weather.unit = .celsius
                let temp = data.currentTemperature?.temperature.value ?? 0;
                weather.currentTemperature?.temperature.value = (temp - 32) * 5/9
                return weather
            }
            return data
        }
    }
    
    private func toFahrenheit() {
        weatherData = weatherData.map { data in
            if data.unit != .fahrenheit {
                var weather = data;
                weather.unit = .fahrenheit
                let temp = data.currentTemperature?.temperature.value ?? 0;
                weather.currentTemperature?.temperature.value = (temp * 9/5) + 32
                return weather
            }
            return data
        }
    }
}
