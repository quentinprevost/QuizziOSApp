//
//  NetworkerTests.swift
//  QuizzAppTests
//
//  Created by Quentin Prevost on 15/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

@testable import QuizzApp
import XCTest

class WebServiceTests: XCTestCase {
    var webService: WebServiceProtocol!

    override func setUp() {
        webService = WebService()
    }

    override func tearDown() {
        webService = nil
    }

    func testGivenAGoodRouteForJSON_whenRequest_ItGiveNotNilCategories() {
        let route = Router.categories
        let expectation = XCTestExpectation(description: "Download Categories")

        webService.request(for: [CategoryQuestion].self, route: route) { categories, _ in
            XCTAssertNotNil(categories, "No data was downloaded.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testGivenAGoodRouteForJSON_whenRequest_ItGiveNilCategories() {
        let route = Router.questions(categoryID: 1)
        let expectation = XCTestExpectation(description: "Download Categories")

        webService.request(for: [CategoryQuestion].self, route: route) { categories, _ in
            XCTAssertNil(categories, "No data was downloaded.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
