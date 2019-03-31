//
//  ForecastViewModel.swift
//  Forecast
//
//  Created by Raul Brito on 31/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import Foundation

class ForecastViewModel {
	
	let forecastService: ForecastServiceProtocol
	
    var forecast: Forecast!
	
    init(forecastService: ForecastServiceProtocol = ForecastService()) {
        self.forecastService = forecastService
    }

    func fetch() {
		forecastService.fetchForecast(type: "daily", range: "1day", key: "178087", completion: { (error, forecast) in
            if let error = error {
				print(error.domain)
				return
			}
			
			self.forecast = forecast
        })
    }
}
