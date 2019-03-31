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
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	
	
	// MARK: - ViewController Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        cityLabel.text = location.city
		countryLabel.text = location.country
		
		viewModelConfiguration()
    }
	
	
    // MARK: - Methods
	
    func viewModelConfiguration() {
    	forecastViewModel.fetchCurrentConditions = { [weak self] () in
            DispatchQueue.main.async {
				self?.temperatureLabel.text = "\(Int(self?.forecastViewModel.currentConditions[0].temperature ?? 0))°"
				
            	UIView.animate(withDuration: 0.6) {
					self?.temperatureLabel.alpha = 1
				}
            }
        }
		
        forecastViewModel.reloadData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
				
                UIView.animate(withDuration: 0.6) {
					self?.tableView.alpha = 1
				}
            }
        }

        forecastViewModel.fetch(type: type, range: range, key: location.key)
	}
	
	@IBAction func close(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
}


// MARK: - Extensions

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return forecastViewModel.forecast.dailyForecasts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as? ForecastTableViewCell
		
		cell?.forecastCellViewModel = forecastViewModel.cellViewModel(at: indexPath)
		
		return cell ?? UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
