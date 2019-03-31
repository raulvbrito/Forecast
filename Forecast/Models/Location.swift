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

//[{"Version":1,"Key":"178087","Type":"City","Rank":10,"LocalizedName":"Berli n","EnglishName":"Berlin","PrimaryPostalCode":"10178","Region":{"ID":"EUR","LocalizedName":"Europe","EnglishName":"Europe"},"Country":{"ID":"DE","LocalizedName":"Germany","EnglishName":"Germany"},"AdministrativeArea":{"ID":"BE","LocalizedName":"Berlin","EnglishName":"Berlin","Level":1,"LocalizedType":"State","EnglishType":"State","CountryID":"DE"},"TimeZone":{"Code":"CET","Name":"Europe/Berlin","GmtOffset":1.0,"IsDaylightSaving":false,"NextOffsetChange":"2019-03-31T01:00:00Z"},"GeoPosition":{"Latitude":52.518,"Longitude":13.406,"Elevation":{"Metric":{"Value":35.0,"Unit":"m","UnitType":5},"Imperial":{"Value":114.0,"Unit":"ft","UnitType":0}}},"IsAlias":false,"SupplementalAdminAreas":[{"Level":2,"LocalizedName":"Berlin","EnglishName":"Berlin"}],"DataSets":["Alerts","MinuteCast"]}]
