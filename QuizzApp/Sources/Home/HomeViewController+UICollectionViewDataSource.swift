//
//  HomeViewController+.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 09/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel?.categoriesCount ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell",
                                                            for: indexPath) as? HomeCollectionViewCell else {
                                                                return HomeCollectionViewCell()
        }

        let categoryTitle = homeViewModel?.getCategoryTitle(for: indexPath) ?? ""
        cell.configure(title: categoryTitle)
        return cell
    }
}