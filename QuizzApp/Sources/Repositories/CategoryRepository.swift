//
//  CategoryRepository.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 09/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import Foundation

protocol CategoryRepositoryProtocol {
    func getCategories(callback: @escaping (([CategoryQuestion]) -> Void))
}

final class CategoryRepository: CategoryRepositoryProtocol {

    // MARK: - Properties

    private let networker: WebServiceProtocol

    // MARK: - Functions

    init(networker: WebServiceProtocol = WebService()) {
        self.networker = networker
    }

    func getCategories(callback: @escaping (([CategoryQuestion]) -> Void)) {
        networker.request(for: [CategoryQuestion].self, route: .categories) { categories, error in
            guard let categories = categories, error == nil else {
                return
            }

            callback(categories)

            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ConstantsCustom.notificationCategoriesLoaded), object: nil)
            }
        }
    }
}
