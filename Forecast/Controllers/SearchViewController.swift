//
//  SearchViewController.swift
//  Forecast
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit
import Hero
import TagListView

class SearchViewController: BaseViewController, Storyboarded {

	// MARK: - Properties
	
	weak var coordinator: MainCoordinator?
	
	lazy var locationViewModel: LocationViewModel = {
        return LocationViewModel(locationService: LocationService())
    }()
	
	var selectedLocation: LocationCellViewModel!
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	@IBOutlet weak var searchBackgroundView: UIView!
	@IBOutlet weak var searchResultView: UIView!
	@IBOutlet weak var searchResultViewTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var searchResultViewHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var countryLabel: UILabel!
	@IBOutlet weak var countryLabelTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var timeFrameTitleLabel: UILabel!
	@IBOutlet weak var tagListView: TagListView! {
		didSet {
			tagListView.textFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
			tagListView.addTags(["1 Day", "5 Days", "10 Days", "15 Days"]) //"1 Hour", "12 Hours", "24 Hours", "72 Hours", "120 Hours"])
			tagListView.tagViews[0].isSelected = true
		}
	}
	@IBOutlet weak var forecastButton: UIButton!
	@IBOutlet weak var forecastButtonArrowImageView: UIImageView!
	
	
	// MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		
        viewModelConfiguration()
    }
	
    override func viewDidAppear(_ animated: Bool) {
		searchResultViewTopConstraint.constant = 16
		
		UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
			self.view.layoutIfNeeded()
		}) { (Bool) in
			self.searchTextField.becomeFirstResponder()
		}
	}
	
	
    // MARK: - Methods
	
    func viewModelConfiguration() {
    	locationViewModel.reloadData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
		
        locationViewModel.fetch()
	}
	
	func selectLocation(location: LocationCellViewModel) {
		searchTextField.isEnabled = false
		searchTextField.text = location.city
		countryLabel.text = location.country
		forecastButton.setTitle("Weather forecast in \(location.city)", for: .normal)
		selectedLocation = location
		
		closeLocationsList(withSearch: false)
		showForecastConfiguration()
	}
	
	func closeLocationsList(withSearch closeSearch: Bool) {
		searchResultViewTopConstraint.constant = 700
		
		UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
			self.view.layoutIfNeeded()
		}) { (Bool) in
			if closeSearch {
				self.dismiss(animated: true, completion: nil)
			}
		}
	}
	
	func showForecastConfiguration() {
		countryLabelTopConstraint.constant = 0
		
		UIView.animate(withDuration: 0.4) {
			self.timeFrameTitleLabel.alpha = 1
			self.tagListView.alpha = 1
			self.forecastButton.alpha = 1
			self.forecastButtonArrowImageView.alpha = 1
			
			self.view.layoutIfNeeded()
		}
	}
	
	@IBAction func textFieldChanged(_ sender: UITextField) {
		
	}
	
	@IBAction func showForecast(_ sender: Any) {
		let selectedRange = tagListView.selectedTags().map({return $0.currentTitle ?? ""})[0].replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "s", with: "")
		let selectedType = selectedRange.contains("Day") ? "daily" : "hourly"
		
		coordinator?.showForecast(from: self, type: selectedType, range: selectedRange, location: selectedLocation)
	}
	
	@IBAction func close(_ sender: Any) {
		searchTextField.resignFirstResponder()
		
		closeLocationsList(withSearch: true)
	}
}


// MARK: - Extensions

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return locationViewModel.locations.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as? LocationTableViewCell
		
		cell?.locationCellViewModel = locationViewModel.cellViewModel(at: indexPath)
		
		return cell ?? UITableViewCell()
	}
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		searchTextField.resignFirstResponder()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		selectLocation(location: locationViewModel.cellViewModel(at: indexPath))
	}
}

extension SearchViewController: TagListViewDelegate {
	
	func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
		UISelectionFeedbackGenerator().selectionChanged()
		
		for tag in sender.selectedTags() {
			tag.isSelected = false
		}
		
		tagView.isSelected = !tagView.isSelected
	}
}

