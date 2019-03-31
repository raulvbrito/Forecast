//
//  ForecastViewController.swift
//  Forecast
//
//  Created by Raul Brito on 31/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

class ForecastViewController: BaseViewController, Storyboarded {
	
	// MARK: - Properties
	
	weak var coordinator: MainCoordinator?
	
	lazy var forecastViewModel: ForecastViewModel = {
		return ForecastViewModel(forecastService: ForecastService())
    }()
	
	var type: String = ""
	var range: String = ""
	var location: LocationCellViewModel!
	
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var countryLabel: UILabel!
	
	
	// MARK: - ViewController Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        cityLabel.text = location.city
		countryLabel.text = location.country
    }
	
	
	// MARK: - Methods
	
	@IBAction func close(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
}
