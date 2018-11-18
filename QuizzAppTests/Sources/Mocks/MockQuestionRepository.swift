//
//  MockQuestionRepository.swift
//  QuizzAppTests
//
//  Created by Quentin Prevost on 17/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

@testable import QuizzApp
import Foundation

final class MockQuestionRepository: QuestionRepositoryProtocol {
    func getQuestions(categoryID: Int, callback: @escaping (([Question]) -> Void)) {
        let answer = Question.Answer(id: 1, text: "text", answeredCount: 1, questionID: 1)
        let question = Question(questionTitle: "title", answers: [answer, answer], votes: 1)
        callback([question, question])
    }
    
    func vote(for answerID: Int) {
    }
}
