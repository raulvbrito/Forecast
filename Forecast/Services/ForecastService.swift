//
//  ForecastService.swift
//  Forecast
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import Foundation
import Alamofire

protocol ForecastServiceProtocol {
	func fetchCurrentConditions(key: String, completion: @escaping (_ error: NSError?, _ result: [CurrentConditions]?) -> Void)
    func fetchForecast(type: String, range: String, key: String, completion: @escaping (_ error: NSError?, _ result: Forecast?) -> Void)
}

class ForecastService: ForecastServiceProtocol {
	
	// MARK: - Properties
	
	let baseUrl = "https://dataservice.accuweather.com"
	let apiKey = "WUzcyBjHRK1oZ2I4qTO4uQUFfnC1H2G5"
	
	
    // MARK: - Requests
	
	func fetchCurrentConditions(key: String, completion: @escaping (_ error: NSError?, _ result: [CurrentConditions]?) -> Void) {
		let url = "\(baseUrl)/currentconditions/v1/\(key)?apikey=\(apiKey)&metric=true"
		
		Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).validate().responseJSON{ response in
			
            switch response.result {
            case .success(let JSON):
				
                //Error
                guard let result = JSON as? JSONArray else {
                    completion(NSError(domain: "Failed to fetch current conditions", code: 400, userInfo: nil), nil)
                    return
                }
				
                //Success
				let currentConditions = result.compactMap(CurrentConditions.init)
				
                completion(nil, currentConditions)
				
                break
				
            default:
				completion(NSError(domain: "Failed to fetch current conditions", code: response.response?.statusCode ?? 400, userInfo: nil), nil)
                break
            }
            return
        }
    }
	
    func fetchForecast(type: String, range: String, key: String, completion: @escaping (_ error: NSError?, _ result: Forecast?) -> Void) {
		let url = "\(baseUrl)/forecasts/v1/\(type)/\(range.lowercased())/\(key)?apikey=\(apiKey)&metric=true"
		
		Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).validate().responseJSON{ response in
			
            switch response.result {
            case .success(let JSON):
				
                //Error
                guard let result = JSON as? JSONDictionary else {
                    completion(NSError(domain: "Failed to fetch forecast", code: 400, userInfo: nil), nil)
                    return
                }
				
                //Success
				let forecast = Forecast(result)
				
                completion(nil, forecast)
				
                break
				
            default:
				completion(NSError(domain: "Failed to fetch forecast", code: response.response?.statusCode ?? 400, userInfo: nil), nil)
                break
            }
            return
        }
    }
	
}
