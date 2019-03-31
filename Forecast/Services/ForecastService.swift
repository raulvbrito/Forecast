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
    func fetchForecast(type: String, range: String, key: String, completion: @escaping (_ error: NSError?, _ result: Forecast?) -> Void)
}

class ForecastService: ForecastServiceProtocol {
	
	// MARK: - Properties
	
	let baseUrl = "https://dataservice.accuweather.com/forecasts/v1"
	let apiKey = "WUzcyBjHRK1oZ2I4qTO4uQUFfnC1H2G5"
	
	
    // MARK: - Requests
	
	func fetchForecast(type: String, range: String, key: String, completion: @escaping (_ error: NSError?, _ result: Forecast?) -> Void) {
		let url = "\(baseUrl)/\(type)/\(range)/\(key)?apikey=\(apiKey)&metric=true"
		
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
