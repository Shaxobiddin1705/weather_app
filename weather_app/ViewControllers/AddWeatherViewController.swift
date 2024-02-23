//
//  AddWeatherViewController.swift
//  weather_app
//
//  Created by Shaxobiddin on 20/02/24.
//

import UIKit

protocol AddWeatherDelegate {
    func sendWeatherData(data: WeatherData)
}

class AddWeatherViewController: UIViewController {

    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityNameTF: UITextField!
    private let networkManager = NetworkingManager()
    lazy var delegate: AddWeatherDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        guard let cityName = cityNameTF.text, !cityName.isEmpty else {return }
        loadingIndicator.startAnimating()
        
        let weatherSource = Resource<WeatherData>(url: EndPoints().weatherByCity(city: cityName)) { data in
            let decodeData = try? JSONDecoder().decode(WeatherData.self, from: data)
            return decodeData
        }
        
        WebService().load(resource: weatherSource) { result in
            print("Temperature: \(result?.currentTemperature?.temperature.value.formatTemp ?? "")")
            if let data = result {
                self.delegate?.sendWeatherData(data: data)
                self.loadingIndicator.stopAnimating()
                self.dismiss(animated: true)
            }
        }
    }
    
}
