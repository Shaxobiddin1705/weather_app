//
//  WeatherData.swift
//  weather_app
//
//  Created by Shaxobiddin on 20/02/24.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let currentTemperature: MainWeather?
    let cityName: Dynamic<String>
    var unit: Unit
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        currentTemperature = try container.decode(MainWeather.self, forKey: .currentTemperature)
        cityName = Dynamic(try container.decode(String.self, forKey: .cityName))
        weather = try container.decode(Array<Weather>.self, forKey: .weather)
        unit = .fahrenheit
    }
    
    private enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case weather = "weather"
        case currentTemperature = "main"
    }
}

struct Weather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct MainWeather: Decodable {
    let temperature: Dynamic<Double>
    let feelsLike: Dynamic<Double>
    let temperatureMin: Dynamic<Double>
    let temperatureMax: Dynamic<Double>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = Dynamic(try container.decode(Double.self, forKey: .temperature))
        feelsLike = Dynamic(try container.decode(Double.self, forKey: .feelsLike))
        temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin))
        temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax))
    }
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
