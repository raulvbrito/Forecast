//
//  LocationViewModelTests.swift
//  ForecastTests
//
//  Created by Raul Brito on 31/03/19.
//  Copyright © 2019 Raul Brito. All rights reserved.
//

import XCTest

@testable import Forecast

class LocationViewModelTests: XCTestCase {

   	var viewModelUnderTest: LocationViewModel!
	fileprivate var service: MockLocationService!

    override func setUp() {
        super.setUp()

		service = MockLocationService()
        viewModelUnderTest = LocationViewModel(locationService: service)
    }

    override func tearDown() {
    	viewModelUnderTest = nil
    	service = nil

        super.tearDown()
    }

    func testFetchLocations() {
        // given
        service.locations = [Location]()


		// when
		viewModelUnderTest.fetch()


        // then
        XCTAssert(service.fetchLocationsCalled)
    }

    func testFetchLocationsFail() {
        // given
        let error = NSError(domain: "Failed to fetch locations", code: 400, userInfo: nil)


		// when
		viewModelUnderTest.fetch()

		service.fetchFail(error: error)


        // then
        XCTAssertEqual(error.domain, "Failed to fetch locations")
    }

    func testFetchLocationsPerformance() {
		measure {
			viewModelUnderTest.fetch()
		}
	}
}

fileprivate class MockLocationService : LocationServiceProtocol {

	var fetchLocationsCalled = false

    var locations: [Location] = [Location]()
    var completion: ((_ error: NSError?, _ result: [Location]) -> Void)!

    func fetchLocations(completion: @escaping (_ error: NSError?, _ result: [Location]) -> Void) {
        fetchLocationsCalled = true
        self.completion = completion
    }

    func fetchSuccess() {
        completion(nil, locations)
    }

    func fetchFail(error: NSError?) {
        completion(error, locations)
    }
}
