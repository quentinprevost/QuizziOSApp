//
//  HomeViewModel.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 08/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

final class HomeViewModel {

    // MARK: - Properties
    private var categories: [CategoryQuestion] = []
    private var questions: [Question] = []
    private let categoryRepository: CategoryRepositoryProtocol
    private let questionRepository: QuestionRepositoryProtocol

    var getAnswersText: [String] {
        guard let question = questions.first, question.answers.count == 2 else {
            loadQuestions()
            return []
        }
        return [question.answers[0].text, question.answers[1].text]
    }

    var categoriesCount: Int {
        return categories.count
    }

    init(categoryRepository: CategoryRepositoryProtocol = CategoryRepository(), questionRepository: QuestionRepositoryProtocol = QuestionRepository()) {
        self.categoryRepository = categoryRepository
        self.questionRepository = questionRepository
        loadCategories()
    }

    func getAnswersStats() -> [String] {
        guard let answers = questions.first else {
            return []
        }

        return answers.answers.map { answer in
            let votes = answers.votes == 0 ? "50%" : "\((answer.answeredCount * 100) / (answers.votes))%"
            return "\(answer.text)\n 🗳 \(votes)"
        }
    }

    private func loadCategories() {
        categoryRepository.getCategories { categories in
            self.categories = categories
            self.loadQuestions()
        }
    }

    var getMessageForSharingQuestion: String {
        guard let firstAnswer = getAnswersText.first, let lastAnswer = getAnswersText.last else {
            return ""
        }

        let message = "What do you prefer ? \n 1️⃣  \(firstAnswer )\n OR \n 2️⃣ \(lastAnswer)"
        return message
    }

    func loadQuestions(row: Int? = nil) {
        guard let firstCategoryID = categories.first else {
            return
        }
        var categoryID = firstCategoryID.id

        if let row = row {
            categoryID = categories[row].id
        }

        questionRepository.getQuestions(categoryID: categoryID) { questions in
            self.questions = questions
        }
    }

    func deleteCurrentQuestion() {
        questions.removeFirst()
    }

    @objc func didSelectAnswer(_ button: UIButton) {
        guard questions.count > 0 else { return }
        guard let question = questions.first, question.answers.count == 2 else {
            return
        }

        let answerID = question.answers[button.tag].id
        questionRepository.vote(for: answerID)
    }

    func getCategoryTitle(for indexPath: IndexPath) -> String {
        return categories[indexPath.row ].title.uppercased()
    }
}
