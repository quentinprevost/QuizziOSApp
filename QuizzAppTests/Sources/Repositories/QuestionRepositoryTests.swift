//
//  QuestionRepository.swift
//  QuizzAppTests
//
//  Created by Quentin Prevost on 17/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

@testable import QuizzApp
import XCTest

class QuestionRepositoryTests: XCTestCase {
    
    var webService: WebServiceProtocol!
    var questionRepository: QuestionRepository!

    override func setUp() {
        webService = MockWebService()
        questionRepository = QuestionRepository(networker: webService)
    }

    override func tearDown() {
        webService = nil
        questionRepository = nil
    }
    
    func testGetQuestionsIsNotEqualZero() {
        questionRepository.getQuestions(categoryID: 1) { questions in
            XCTAssertNotEqual(questions.count, 0)
        }
    }
}
