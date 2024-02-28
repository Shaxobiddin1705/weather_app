//
//  WeatherDataEntity+CoreDataProperties.swift
//  weather_app
//
//  Created by Shaxobiddin on 27/02/24.
//
//

import Foundation
import CoreData


extension WeatherDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherDataEntity> {
        return NSFetchRequest<WeatherDataEntity>(entityName: "WeatherDataEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var temperature: Double
    @NSManaged public var isCelsius: Bool

}

extension WeatherDataEntity : Identifiable {

}
