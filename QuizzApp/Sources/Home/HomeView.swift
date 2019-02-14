//
//  HomeView.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 06/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import UIKit

final class HomeView: EasyView {

    // MARK: - Properties

    private(set) var buttons: [UIButton] = []

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureView()
    }

    private func configureView() {
        backgroundColor = ConstantsCustom.backgroundColor
        generateButtons()
        addViews()
        activateConstraints()
    }

    private func addViews() {
        addSubview(logoLabel)
        addSubview(collectionView)
        addSubview(bottomStackView)
        addSubview(questionsStackView)
        addSubview(spinner)
    }

    private func activateConstraints() {
        activeConstraintsLogoLabel()
        activeConstraintsCollectionView()
        activateConstraintsBottomStackView()
        activateConstraintsQuestionsStackView()
        activateConstraintsNextButton()
        activateConstraintsActivityIndicatorView()
    }

    // MARK: - Views

    private lazy var questionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()

    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shareImageView, nextButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 3
        return stackView
    }()

    let shareImageView: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "share"))
        image.contentMode = .scaleAspectFit
        return image
    }()

    let nextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.backgroundColor = ConstantsCustom.nextButtonColor
        button.titleLabel?.font = button.titleLabel?.font.withSize(30)
        button.setTitle("NEXT QUESTION", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10.0
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.clipsToBounds = true
        button.titleLabel?.minimumScaleFactor = 0.3
        return button
    }()

    private func generateButtons() {
        for index in 0..<2 {
            let button = UIButton()
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.1
            button.titleLabel?.font = button.titleLabel?.font.withSize(25)
            button.titleLabel?.textColor = .green
            button.backgroundColor = ConstantsCustom.buttonBackgroundColor
            button.layer.cornerRadius = 15.0
            button.tag = index
            buttons.append(button)
        }
    }

    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you prefer ?".capitalized
        label.textColor = .white
        label.textAlignment = .center
        label.font = label.font.withSize(30)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: 120, height: 40)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: ConstantsCustom.categoriesCollectionCell)
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1125306832)
        collectionView.autoresizesSubviews = true

        return collectionView
    }()

    let spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        return indicator
    }()

    // MARK: - Constraints

    private func activateConstraintsNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = nextButton.widthAnchor.constraint(equalToConstant: 180)
        NSLayoutConstraint.activate([
            widthConstraint
        ])
    }

    private func activateConstraintsActivityIndicatorView() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerYConstraint = spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([
            centerXConstraint,
            centerYConstraint
        ])
    }

    private func activateConstraintsBottomStackView() {
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = bottomStackView.topAnchor.constraint(equalTo: questionsStackView.bottomAnchor, constant: 20)
        let heightConstraint = bottomStackView.heightAnchor.constraint(equalToConstant: 50)
        let bottomConstraint = bottomStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5)
        let centerXAnchorConstraint = bottomStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        NSLayoutConstraint.activate([
            heightConstraint,
            topConstraint,
            centerXAnchorConstraint,
            bottomConstraint
        ])
    }

    private func activeConstraintsLogoLabel() {
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = logoLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailingConstraint = logoLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        let heightConstraint = logoLabel.heightAnchor.constraint(equalToConstant: 30)
        let topConstraint = logoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate([
            leadingConstraint,
            heightConstraint,
            topConstraint,
            trailingConstraint
        ])
    }

    private func activateConstraintsQuestionsStackView() {
        questionsStackView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = questionsStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20)
        let leadingConstraint = questionsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        let trailingConstraint = questionsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            trailingConstraint
        ])
    }

    private func activeConstraintsCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailingConstraint = collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        let heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 50)
        let topConstraint = collectionView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 10)
        NSLayoutConstraint.activate([
            topConstraint,
            heightConstraint,
            leadingConstraint,
            trailingConstraint
        ])
    }
}
