//
//  CategoryRepositoriesTests.swift
//  QuizzAppTests
//
//  Created by Quentin Prevost on 17/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

@testable import QuizzApp
import XCTest

class CategoryRepositoryTests: XCTestCase {

    var webService: WebServiceProtocol!
    var categoryRepository: CategoryRepository!
    
    override func setUp() {
        webService = MockWebService()
        categoryRepository = CategoryRepository(networker: webService)
    }

    override func tearDown() {
        webService = nil
        categoryRepository = nil
    }
    
    func testGetCategoriesIsNotEqualZero() {
        categoryRepository.getCategories { categories in
            XCTAssertNotEqual(categories.count, 0)
        }
    }
}
