//
//  LocationService.swift
//  Forecast
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import Foundation
import Alamofire

protocol LocationServiceProtocol {	
    func fetchLocations(completion: @escaping (_ error: NSError?, _ result: [Location]) -> Void)
}

class LocationService: LocationServiceProtocol {
	
	// MARK: - Properties
	
	let baseUrl = "https://dataservice.accuweather.com"
	let apiKey = "nFA5uitaXXDakiYMgTQbejSDtT4yIn8P"
	
	
    // MARK: - Requests
	
    func fetchLocations(completion: @escaping (_ error: NSError?, _ result: [Location]) -> Void) {
		let url = "\(baseUrl)/locations/v1/topcities/50?apikey=\(apiKey)"
		
		Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).validate().responseJSON{ response in
			
            switch response.result {
            case .success(let JSON):
				
                //Error
                guard let result = JSON as? JSONArray else {
                    completion(NSError(domain: "Failed to fetch locations", code: 400, userInfo: nil), [])
                    return
                }
				
                //Success
				let locations = result.compactMap(Location.init)
				
                completion(nil, locations)
				
                break
				
            default:
				completion(NSError(domain: "Failed to fetch locations", code: response.response?.statusCode ?? 400, userInfo: nil), [])
                break
            }
            return
        }
    }
	
}
