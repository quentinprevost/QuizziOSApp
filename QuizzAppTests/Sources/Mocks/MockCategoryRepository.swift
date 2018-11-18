//
//  MockCategoryRepository.swift
//  QuizzAppTests
//
//  Created by Quentin Prevost on 17/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

@testable import QuizzApp
import Foundation

final class MockCategoryRepository: CategoryRepositoryProtocol {

    func getCategories(callback: @escaping (([CategoryQuestion]) -> Void)) {
        let category = CategoryQuestion(title: "Title", id: 1)
        callback([category, category])
    }
}
