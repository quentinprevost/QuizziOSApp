//
//  HomeViewController+.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 09/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource {

    // MARK: - Functions

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel?.categoriesCount ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConstantsCustom.categoriesCollectionCell,
                                                            for: indexPath) as? HomeCollectionViewCell else {
                                                                fatalError()
        }

        let categoryTitle = homeViewModel?.getCategoryTitle(for: indexPath) ?? ""
        cell.configure(title: categoryTitle)
        return cell
    }
}
