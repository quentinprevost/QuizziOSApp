//
//  HomeViewController.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 06/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import UIKit
import Alamofire

final class HomeViewController: UIViewController {

    // MARK: - Properties
    private(set) var homeView: HomeView!
    private(set) var homeViewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewModel = HomeViewModel()
        self.homeViewModel = homeViewModel
        configureViews()
        configureIntereactions()
    }

    // MARK: Private Functions
    private func configureViews() {
        homeView = HomeView()
        view = homeView
        configureCollectionView()
    }

    private func configureIntereactions() {
        activateObserver()
        activateEvents()
        activateShareImageGesture()
    }

    private func activateObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.reloadCollectionView), name: NSNotification.Name(rawValue: "categoriesLoaded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.displayAnswers), name: NSNotification.Name(rawValue: "questionsLoaded"), object: nil)
    }

    private func activateEvents() {
        for button in homeView.buttons {
            button.addTarget(self, action: #selector(HomeViewController.didSelectAnswer(_:)), for: .touchUpInside)
        }
        homeView.nextButton.addTarget(self, action: #selector(HomeViewController.didTouchNextButton), for: .touchUpInside)
    }

    private func configureCollectionView() {
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }

    @objc private func reloadCollectionView() {
        guard homeViewModel.categoriesCount > 1 else {
            return
        }

        homeView.collectionView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        homeView.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
    }

    @objc private func displayAnswers() {
        let answers = homeViewModel.getAnswersText

        guard answers.count == 2 else { return }

        for (index, answer) in answers.enumerated() {
            homeView.buttons[index].setTitle(answer.capitalized, for: .normal)
            homeView.buttons[index].backgroundColor = #colorLiteral(red: 0.2823529412, green: 0.2392156863, blue: 0.5450980392, alpha: 1)
            homeView.buttons[index].isEnabled = true
        }
        homeView.spinner.stopAnimating()
    }

    @objc private func didSelectAnswer(_ button: UIButton) {
        let stats = homeViewModel.getAnswersStats()
        guard stats.count == 2, homeView.buttons.count == 2 else {
            return
        }

        button.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)

        for (index, stats) in stats.enumerated() {
            homeView.buttons[index].setTitle(stats, for: .normal)
            homeView.buttons[index].isEnabled = false
        }
        self.homeViewModel.didSelectAnswer(button)
    }

    private func activateShareImageGesture() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.didTouchShareImageView))
        homeView.shareImageView.isUserInteractionEnabled = true
        homeView.shareImageView.addGestureRecognizer(tapRecognizer)
    }

    @objc private func didTouchShareImageView() {
        let textToShare = [homeViewModel.getMessageForSharingQuestion]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }

    @objc private func didTouchNextButton() {
        homeViewModel.deleteCurrentQuestion()
        displayAnswers()
    }
}