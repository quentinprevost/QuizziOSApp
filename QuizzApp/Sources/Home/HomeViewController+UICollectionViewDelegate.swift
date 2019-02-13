//
//  HomeViewController+.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 09/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate {

    // MARK: - Functions

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeView.spinner.startAnimating()
        homeViewModel.loadQuestions(row: indexPath.row)
    }
}
