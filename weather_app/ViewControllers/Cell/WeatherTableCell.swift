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
    
    func setData(data: WeatherDataEntity) {
        leadingLabel.text = data.name
        trailingLabel.text = data.temperature.formatTemp
    }

}
