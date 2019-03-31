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
	
	private var forecastCellViewModels: [ForecastCellViewModel] = [ForecastCellViewModel]() {
        didSet {
            self.reloadData?()
        }
    }
	
	var currentConditions: [CurrentConditions] = [CurrentConditions]() {
        didSet {
            self.fetchCurrentConditions?()
        }
    }
	
	var forecast: Forecast! = Forecast([:])
	
	var reloadData: (()->())?
	var fetchCurrentConditions: (()->())?
	
    init(forecastService: ForecastServiceProtocol = ForecastService()) {
        self.forecastService = forecastService
    }

    func fetch(type: String, range: String, key: String) {
    	forecastService.fetchCurrentConditions(key: key, completion: { (error, currentConditions) in
            if let error = error {
				print(error.domain)
				return
			}
			
			self.currentConditions = currentConditions ?? []
        })
		
		forecastService.fetchForecast(type: type, range: range, key: key, completion: { (error, forecast) in
            if let error = error {
				print(error.domain)
				return
			}
			
			self.forecast = forecast
			self.forecastCellViewModels = forecast?.dailyForecasts.map({return ForecastCellViewModel(minimumTemperature: $0.minimumTemperature, maximumTemperature: $0.maximumTemperature, dayDescription: $0.dayDescription, epochDate: $0.epochDate)}) ?? []
        })
    }
	
    func cellViewModel(at indexPath: IndexPath) -> ForecastCellViewModel {
        return forecastCellViewModels[indexPath.row]
    }
}

struct ForecastCellViewModel {
	let minimumTemperature: Double
    let maximumTemperature: Double
    let dayDescription: String
    let epochDate: Double
}
