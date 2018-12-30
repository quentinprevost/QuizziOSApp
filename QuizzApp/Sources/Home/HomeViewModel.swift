//
//  HomeViewModel.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 08/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import Foundation
import Alamofire

final class HomeViewModel {

    // MARK: - Properties
    private var categories: [CategoryQuestion] = []
    private(set) var questions: [Question] = []
    private let categoryRepository: CategoryRepositoryProtocol
    private let questionRepository: QuestionRepositoryProtocol

    init(categoryRepository: CategoryRepositoryProtocol = CategoryRepository(), questionRepository: QuestionRepositoryProtocol = QuestionRepository()) {
        self.categoryRepository = categoryRepository
        self.questionRepository = questionRepository
        loadCategories()
    }

    var getAnswersText: [String] {
        guard let question = questions.first else {
            loadQuestions()
            return []
        }

        return question.answers.map { $0.text }
    }

    var categoriesCount: Int {
        return categories.count
    }

    var getMessageForSharingQuestion: String {
        guard let firstAnswer = getAnswersText.first, let secondAnswer = getAnswersText.last else {
            return ""
        }

        return UIViewConstant.sharingMessage(firstAnswer: firstAnswer, secondAnswer: secondAnswer)
    }

    // MARK: - Functions
    func getAnswersStats() -> [String] {
        guard let question = questions.first else {
            return []
        }

        return question.answers.map { answer in
            let percentage = getPercentage(question: question, answer: answer)
            return "\(answer.text)\n 🗳 \(percentage)"
        }
    }

    func loadQuestions(row: Int? = nil) {
        guard let firstCategoryID = categories.first else {
            return
        }
        var categoryID = firstCategoryID.id

        if let row = row {
            categoryID = categories[row].id
        }

        questionRepository.getQuestions(categoryID: categoryID) { [weak self] questions in
            guard let self = self else { return }
            self.questions = questions
        }
    }

    func deleteCurrentQuestion() {
        questions.removeFirst()
    }

    func vote(for tag: Int) {
        guard let question = questions.first, questions.count > 0 else {
            return
        }

        let answerID = question.answers[tag].id
        questionRepository.vote(for: answerID)
    }

    func getCategoryTitle(for indexPath: IndexPath) -> String {
        return categories[indexPath.row ].title.uppercased()
    }

    // MARK: - Private functions
    private func loadCategories() {
        categoryRepository.getCategories { [weak self] categories in
            guard let self = self else { return }
            self.categories = categories
            self.loadQuestions()
        }
    }

    private func getPercentage(question: Question, answer: Question.Answer) -> String {
        return question.votes == 0 ? "50%" : "\((answer.answeredCount * 100) / (question.votes))%"
    }
}
