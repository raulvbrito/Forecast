//
//  LocationTableViewCell.swift
//  Forecast
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
	
	// MARK: - Properties
	
	var locationCellViewModel: LocationCellViewModel! {
		didSet {
			cityLabel.text = locationCellViewModel.city
			countryLabel.text = locationCellViewModel.country
		}
	}
	
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var countryLabel: UILabel!
	
}
