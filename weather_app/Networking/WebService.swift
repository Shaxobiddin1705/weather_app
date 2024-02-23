//
//  WebService.swift
//  weather_app
//
//  Created by Shaxobiddin on 21/02/24.
//

import Foundation

struct Resource<T> {
    let url: String
    let parse: (Data) -> T?
}

final class WebService {
    func load<T>(resource: Resource<T>, completion: @escaping(T?) -> ()) {
        
        guard let url = URL(string: resource.url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}

struct EndPoints {
    private let base = "https://api.openweathermap.org/data/2.5/"
    private let apiKey = "b2563e0b02493cdcd399636c21b70348"
    
    func weatherByCity(city: String) -> String {
        "\(base)weather?q=\(city)&appid=\(apiKey)&units=imperial"
    }
}
