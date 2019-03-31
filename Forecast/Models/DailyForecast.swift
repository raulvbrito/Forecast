//
//  DailyForecast.swift
//  Forecast
//
//  Created by Raul Brito on 31/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import Foundation
import Tailor

struct DailyForecast: Mappable {
	
	var minimumTemperature: Int!
	var maximumTemperature: Int!
	var date: String!
	var epochDate: String!
	var dayIcon: Int!
	var dayDescription: String!
	var nightIcon: Int!
	var nightDescription: String!
	
	init(_ map: JSONDictionary) {
		minimumTemperature <- map.resolve(keyPath: "Temperature.Minimum.UnitType")
		maximumTemperature <- map.resolve(keyPath: "Temperature.Maximum.UnitType")
		date <- map.property("Date")
		date <- map.property("EpochDate")
        dayIcon <- map.resolve(keyPath: "Day.Icon")
        dayDescription <- map.resolve(keyPath: "Day.IconPhrase")
        nightIcon <- map.resolve(keyPath: "Night.Icon")
        nightDescription <- map.resolve(keyPath: "Night.IconPhrase")
	}
}
