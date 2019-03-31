//
//  LocationServiceTests.swift
//  ForecastTests
//
//  Created by Raul Brito on 30/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import XCTest

@testable import Forecast

class LocationServiceTests: XCTestCase {

	var serviceUnderTest: LocationService!

    override func setUp() {
        super.setUp()
		
        serviceUnderTest = LocationService()
    }

    override func tearDown() {
    	serviceUnderTest = nil
		
        super.tearDown()
    }

    func testLocationService() {
        // given
        let promise = expectation(description: "Status code: 200")
		var responseError: Error?
		
		
		// when
		serviceUnderTest.fetchLocations { (error, locations) in
			responseError = error
			promise.fulfill()
        }
		
        waitForExpectations(timeout: 5, handler: nil)
		
		
        // then
        XCTAssertNil(responseError)
    }
	
    func testLocationServicePerformance() {
		measure {
			serviceUnderTest.fetchLocations(completion: { (error, locations) in })
		}
	}
}
