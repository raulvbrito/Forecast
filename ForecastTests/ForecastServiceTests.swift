//
//  ForecastServiceTests.swift
//  ForecastTests
//
//  Created by Raul Brito on 31/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import XCTest

@testable import Forecast

class ForecastServiceTests: XCTestCase {

	var serviceUnderTest: ForecastService!

    override func setUp() {
        super.setUp()
		
        serviceUnderTest = ForecastService()
    }

    override func tearDown() {
    	serviceUnderTest = nil
		
        super.tearDown()
    }

    func test1DayForecastRange() {
        // given
        let promise = expectation(description: "Status code: 200")
		var responseError: Error?
		
		
		// when
		serviceUnderTest.fetchForecast(type: "daily", range: "1day", key: "178087") { (error, forecast) in
			responseError = error
			promise.fulfill()
		}
		
        waitForExpectations(timeout: 5, handler: nil)
		
		
        // then
        XCTAssertNil(responseError)
    }
	
    func test1HourForecastRange() {
        // given
        let promise = expectation(description: "Status code: 200")
		var responseError: Error?
		
		
		// when
		serviceUnderTest.fetchForecast(type: "hourly", range: "1hour", key: "178087") { (error, forecast) in
			responseError = error
			promise.fulfill()
		}
		
        waitForExpectations(timeout: 5, handler: nil)
		
		
        // then
        XCTAssertNil(responseError)
    }
	
    func testLocationServicePerformance() {
		measure {
			serviceUnderTest.fetchForecast(type: "daily", range: "1day", key: "178087") { (error, forecast) in }
		}
	}
}
