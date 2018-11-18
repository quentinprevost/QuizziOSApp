//
//  Question.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 07/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import Foundation

struct Question: Codable {
    let questionTitle: String
    let answers: [Answer]
    let votes: Int

    struct Answer: Codable {
        let id: Int
        let text: String
        let answeredCount: Int
        let questionID: Int
    }
}
