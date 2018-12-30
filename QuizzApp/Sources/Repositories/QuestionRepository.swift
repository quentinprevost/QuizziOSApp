//
//  QuestionRepository.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 09/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import Foundation

protocol QuestionRepositoryProtocol {
    func getQuestions(categoryID: Int, callback: @escaping (([Question]) -> Void))
    func vote(for answerID: Int)
}

final class QuestionRepository: QuestionRepositoryProtocol {

    // MARK: - Properties
    private let networker: WebServiceProtocol

    // MARK: - Functions
    init(networker: WebServiceProtocol = WebService()) {
        self.networker = networker
    }

    func getQuestions(categoryID: Int, callback: @escaping (([Question]) -> Void)) {
        networker.request(for: [Question].self, route: .questions(categoryID: categoryID)) { questions, error in
            guard let questions = questions, error == nil else {
                return
            }
            callback(questions)
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "questionsLoaded"), object: nil)
            }
        }
    }

    func vote(for answerID: Int) {
        let parameters = ["id": answerID]
        networker.request(for: Question.Answer.self, route: .vote(parameters: parameters), completion: nil)
    }
}
