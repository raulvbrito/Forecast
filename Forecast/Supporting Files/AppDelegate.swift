//
//  AppDelegate.swift
//  Forecast
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	var coordinator: MainCoordinator?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		// Initial View Controller configuration
		
		let navigationController = UINavigationController()

		coordinator = MainCoordinator(navigationController: navigationController)
		coordinator?.start()
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {}

	func applicationDidEnterBackground(_ application: UIApplication) {}

	func applicationWillEnterForeground(_ application: UIApplication) {}

	func applicationDidBecomeActive(_ application: UIApplication) {}

	func applicationWillTerminate(_ application: UIApplication) {}


}

