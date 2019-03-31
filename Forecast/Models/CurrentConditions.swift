//
//  CurrentConditions.swift
//  Forecast
//
//  Created by Raul Brito on 31/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import Foundation
import Tailor

struct CurrentConditions: Mappable {
	
	var title: String!
	var icon: Int!
	var epochDate: Double!
	var temperature: Double!
	
	init(_ map: JSONDictionary) {
		title <- map.resolve(keyPath: "WeatherText")
		icon <- map.property("WeatherIcon")
		epochDate <- map.resolve(keyPath: "EpochTime")
        temperature <- map.resolve(keyPath: "Temperature.Metric.Value")
	}
}
