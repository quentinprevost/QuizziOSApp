//
//  HomeViewModelTests.swift
//  QuizzAppTests
//
//  Created by Quentin Prevost on 17/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

@testable import QuizzApp
import XCTest

class HomeViewModelTests: XCTestCase {

    var categoryRepository: CategoryRepositoryProtocol!
    var questionRepository: QuestionRepositoryProtocol!
    var homeViewModel: HomeViewModel!

    override func setUp() {
        self.categoryRepository = MockCategoryRepository()
        self.questionRepository = MockQuestionRepository()
        self.homeViewModel = HomeViewModel(categoryRepository: categoryRepository, questionRepository: questionRepository)
        homeViewModel.loadQuestions()
    }

    override func tearDown() {
        categoryRepository = nil
        questionRepository = nil
        homeViewModel = nil
    }

    func testGetAnswersStatsResponseIsNotEqualZero() {
        let response = homeViewModel.getAnswersStats()
        XCTAssertNotEqual(response.count, 0)
    }

    func testGetMessageForSharingQuestionResponseIsNotEmpty() {
        let response = homeViewModel.getMessageForSharingQuestion
        print(response)
        XCTAssertNotEqual(response, "")
    }

    func testDeleteCurrentQuestionWorks() {
        let beforeQuestionscount = homeViewModel.questions.count
        homeViewModel.deleteCurrentQuestion()
        XCTAssertNotEqual(beforeQuestionscount, homeViewModel.questions.count)
    }
}
