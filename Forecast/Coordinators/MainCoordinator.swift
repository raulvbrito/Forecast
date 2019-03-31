//
//  MainCoordinator.swift
//  Forecast
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
	
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = LocationViewController.instantiate()
        viewController.coordinator = self
		
		navigationController.hero.isEnabled = true
        navigationController.pushViewController(viewController, animated: false)
    }
	
    func showLocationSearch() {
    	let viewController = SearchViewController.instantiate()
        viewController.coordinator = self
		viewController.modalPresentationStyle = .custom
		viewController.modalTransitionStyle = .crossDissolve
		
		navigationController.hero.isEnabled = true
		self.navigationController.present(viewController, animated: true, completion: nil)
	}
	
	func showForecast(from parentViewController: UIViewController, type: String, range: String, location: LocationCellViewModel) {
    	let viewController = ForecastViewController.instantiate()
        viewController.coordinator = self
		viewController.modalPresentationStyle = .custom
		viewController.modalTransitionStyle = .crossDissolve
		viewController.type = type
		viewController.range = range
		viewController.location = location
		
		navigationController.hero.isEnabled = true
		parentViewController.present(viewController, animated: true, completion: nil)
	}
}

