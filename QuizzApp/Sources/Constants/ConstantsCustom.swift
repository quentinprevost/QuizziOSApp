//
//  UIViewConstants.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 30/12/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import UIKit

struct ConstantsCustom {

    // MARK: - Properties

    static let categoriesCollectionCell = "categoriesCollectionCell"
    static let backgroundColor: UIColor = .black
    static let nextButtonColor: UIColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    static let buttonBackgroundColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    static let notificationCategoriesLoaded = "categoriesLoaded"
    static let notificationQuestionsLoaded = "questionsLoaded"

    // MARK: - Functions

    static func sharingMessage(firstAnswer: String, secondAnswer: String) -> String {
        return "What do you prefer ? \n 1️⃣  \(firstAnswer )\n OR \n 2️⃣ \(secondAnswer)"
    }
}
