//
//  MockWebService.swift
//  QuizzAppTests
//
//  Created by Quentin Prevost on 15/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

@testable import QuizzApp
import XCTest

class MockWebService: WebServiceProtocol {

    func request<T>(for type: T.Type, route: Router, completion: ((T?, Error?) -> Void)?) where T: Decodable, T: Encodable {
        switch route {
        case .categories:
            let category = CategoryQuestion(title: "title", id: 1)
            if let categories = [category] as? T {
                completion?(categories, nil)
            }
        case .questions:
            let answer = Question.Answer(id: 1, text: "Answer title", answeredCount: 1, questionID: 1)
            let question = Question(questionTitle: "Title", answers: [answer], votes: 1)
            if let questions = [question] as? T {
                completion?(questions, nil)
            }
        case .vote:
            break
        }
    }
}
