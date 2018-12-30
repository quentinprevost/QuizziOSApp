//
//  UIViewConstants.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 30/12/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import Foundation

struct UIViewConstant {
    // MARK: - Properties
    static let categoriesCollectionCell = "categoriesCollectionCell"

    // MARK: - Functions
    static func sharingMessage(firstAnswer: String, secondAnswer: String) -> String {
        return "What do you prefer ? \n 1️⃣  \(firstAnswer )\n OR \n 2️⃣ \(secondAnswer)"
    }
    
    
}
