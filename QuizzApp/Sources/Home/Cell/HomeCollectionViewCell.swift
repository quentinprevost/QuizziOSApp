//
//  HomeCollectionViewCell.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 06/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    override var isSelected: Bool {
        didSet {
            if isSelected {
                categoryLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            } else {
                categoryLabel.textColor = .white
            }
        }
    }

    func configure(title: String) {
        addSubview(categoryLabel)
        activeConstraintsLabel()
        categoryLabel.text = title
    }

    // MARK: - Views

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(25)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        return label
    }()

    // MARK: - Constraints

    private func activeConstraintsLabel() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerYConstraint = categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        let widthConstraint = categoryLabel.widthAnchor.constraint(equalToConstant: frame.width)
        let heightConstraint = categoryLabel.heightAnchor.constraint(equalToConstant: frame.height)
        NSLayoutConstraint.activate([
            centerXConstraint,
            centerYConstraint,
            widthConstraint,
            heightConstraint
        ])
    }
}
