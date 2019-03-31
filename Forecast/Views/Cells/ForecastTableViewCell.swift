//
//  ForecastTableViewCell.swift
//  Forecast
//
//  Created by Raul Brito on 31/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

	// MARK: - Properties

	var forecastCellViewModel: ForecastCellViewModel! {
		didSet {
			maximumTemperatureLabel.text = "\(Int(forecastCellViewModel.maximumTemperature))°"
			minimumTemperatureLabel.text = "\(Int(forecastCellViewModel.minimumTemperature))°"
			descriptionLabel.text = forecastCellViewModel.dayDescription.lowercased()
			
			let date = Date(timeIntervalSince1970: forecastCellViewModel.epochDate)
		
			let dateFormatter = DateFormatter()
			
			dateFormatter.dateFormat = "dd MMM"
			dateFormatter.string(from: date)
			
			dateLabel.text = dateFormatter.string(from: date).uppercased()
		}
	}
	
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var maximumTemperatureLabel: UILabel!
	@IBOutlet weak var minimumTemperatureLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	
	override func awakeFromNib() {
		containerView.layer.borderColor = UIColor.lightGray.cgColor
	}
}
