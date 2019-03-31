//
//  Coordinator.swift
//  Forecast
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}
