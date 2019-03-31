//
//  LocationViewModel.swift
//  Forecast
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import Foundation

class LocationViewModel {
	
	let locationService: LocationServiceProtocol
	
	private var locationCellViewModels: [LocationCellViewModel] = [LocationCellViewModel]() {
        didSet {
            self.reloadData?()
        }
    }
	
    var locations: [Location] = [Location]()
	
    var reloadData: (()->())?
	
    init(locationService: LocationServiceProtocol = LocationService()) {
        self.locationService = locationService
    }

    func fetch() {
		locationService.fetchLocations { (error, locations) in
            if let error = error {
				print(error.domain)
				return
			}
			
			self.locations = locations
			self.locationCellViewModels = locations.map({return LocationCellViewModel(key: $0.key, city: $0.city, country: $0.country)})
        }
    }
	
	func cellViewModel(at indexPath: IndexPath) -> LocationCellViewModel {
        return locationCellViewModels[indexPath.row]
    }
}

struct LocationCellViewModel {
	let key: String
    let city: String
    let country: String
}

