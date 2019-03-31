//
//  LocationViewController.swift
//  Forecast
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

class LocationViewController: BaseViewController, Storyboarded {
	
	// MARK: - Properties
	
	weak var coordinator: MainCoordinator?
	
	@IBOutlet weak var searchTextField: UITextField!
	
	
	// MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
    override func viewWillAppear(_ animated: Bool) {
    	super.viewWillAppear(animated)
	}
}


// MARK: - Extensions

extension LocationViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		searchTextField.resignFirstResponder()
		coordinator?.showLocationSearch()
		
		UISelectionFeedbackGenerator().selectionChanged()
	}
}
