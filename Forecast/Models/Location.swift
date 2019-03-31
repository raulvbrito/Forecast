//
//  Location.swift
//  Forecast
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import Foundation
import Tailor

struct Location: Mappable {
	
	var key: String!
	var city: String!
	var country: String!
	var type: String!
	var latitude: Double!
	var longitude: Double!
	
	init(_ map: JSONDictionary) {
		key <- map.property("Key")
        city <- map.property("LocalizedName")
        country <- map.resolve(keyPath: "Country.LocalizedName")
        type <- map.property("Type")
        latitude <- map.resolve(keyPath: "GeoPosition.Longitude")
        longitude <- map.resolve(keyPath: "GeoPosition.Latitude")
	}
}
