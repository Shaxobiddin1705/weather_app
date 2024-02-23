//
//  WeatherTableCell.swift
//  weather_app
//
//  Created by Shaxobiddin on 21/02/24.
//

import UIKit

class WeatherTableCell: UITableViewCell {
    
    @IBOutlet weak var leadingLabel: UILabel!
    
    @IBOutlet weak var trailingLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(data: WeatherData) {
        leadingLabel.text = data.cityName.value
        trailingLabel.text = data.currentTemperature?.temperature.value.formatTemp
    }

}
