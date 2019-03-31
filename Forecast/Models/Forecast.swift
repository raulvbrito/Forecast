//
//  Forecast.swift
//  Forecast
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import Foundation
import Tailor

struct Forecast: Mappable {
	
	var title: String!
	var severity: Int!
	var date: String!
	var epochDate: Int!
	var link: String!
	var dailyForecasts: [DailyForecast] = []
	
	init(_ map: JSONDictionary) {
		title <- map.resolve(keyPath: "Headline.Text")
		severity <- map.resolve(keyPath: "Headline.Severity")
		date <- map.resolve(keyPath: "Headline.EffectiveDate")
		epochDate <- map.resolve(keyPath: "Headline.EffectiveEpochDate")
        link <- map.resolve(keyPath: "Headline.MobileLink")
        dailyForecasts <- map.relations("DailyForecasts")
	}
}
