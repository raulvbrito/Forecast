//
//  BaseViewController.swift
//  Forecast
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String : Any]
typealias JSONArray = [[String : Any]]

class BaseViewController: UIViewController {

	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationController?.navigationBar.isTranslucent = false
		
		self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
		
		definesPresentationContext = true
    }

}
