//
//  Router.swift
//  TwitterApp
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
import TwitterCore

enum RouterType {

    case tweetController
    case detailTweetController
    case authentication
}

class Router {

    // MARK: - Variable
    fileprivate var coordinator: ViewModelCoordinatorProtocol
    init(coordinator: ViewModelCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Public
    func initMainWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = handleRouter(type: .tweetController)
        window.makeKeyAndVisible()
        return window
    }
}

// MARK: - Private
extension Router {

    fileprivate func handleRouter(type: RouterType) -> UIViewController {
        switch type {
        case .tweetController:
            let controller = TweetViewController.xib()
            let navigation = UINavigationController(rootViewController: controller)
            return navigation
        default:
            return UIViewController()
        }
    }
}
