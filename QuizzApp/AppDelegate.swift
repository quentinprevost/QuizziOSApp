//
//  AppDelegate.swift
//  QuizzApp
//
//  Created by Quentin Prevost on 05/11/2018.
//  Copyright © 2018 Quentin Prevost. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let homeViewController = HomeViewController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = homeViewController

        return true
    }
}
