//
//  NetworkingManager.swift
//  weather_app
//
//  Created by Shaxobiddin on 20/02/24.
//

import Foundation

class NetworkingManager {
    
    func getWeatherData(cityName: String, handler: @escaping(WeatherData?) -> ()) {
        let apiKey = "b2563e0b02493cdcd399636c21b70348"
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)") else {return}
        
        var resuest = URLRequest(url: url)
        resuest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: resuest) { data, response, error in
            let response = response as? HTTPURLResponse
            
            if let data = data, let response = response, response.statusCode == 200 {
                if let decodedData = try? JSONDecoder().decode(WeatherData.self, from: data) {
                    DispatchQueue.main.async {
                        handler(decodedData)
                    }
                    return
                }
            } else {
                handler(nil)
            }
        }.resume()
    }
}
