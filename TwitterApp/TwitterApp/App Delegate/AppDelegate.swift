//
//  AppDelegate.swift
//  TwitterApp
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import UIKit
import TwitterCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Variable
    fileprivate var router: Router!

    // Window
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Handle main window
        let coordinator = ViewModelCoordinator.defaultApp()
        router = Router(coordinator: coordinator)
        window = router.initMainWindow()

        return true
    }
}

