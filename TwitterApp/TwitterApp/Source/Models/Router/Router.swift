//
//  Router.swift
//  TwitterApp
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
import TwitterCore


/// RouterType represent the type of router
/// In conjunction with Router for handling the flow of whole app appropriately
///
/// - tweetController: TweetController
/// - detailTweetController: DetailTweetController
/// - authentication: AuthenticationController
enum RouterType {

    case tweetController
    case detailTweetController
    case authentication
}

// MARK: - Router
class Router {

    // MARK: - Variable
    fileprivate var coordinator: ViewModelCoordinatorProtocol

    // MARK: - Init
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

    /// Defind the core of router
    ///
    /// - Parameter type: RouterType's instance
    /// - Returns: Desised controller
    fileprivate func handleRouter(type: RouterType) -> UIViewController {
        switch type {
        case .tweetController:

            // Get from XIB
            let controller = TweetViewController.xib()

            // Wire view model
            controller.viewModel = coordinator.twitterViewModel

            // Attach to UINavigationController
            let navigation = UINavigationController(rootViewController: controller)
            return navigation

        default: // Didn't support yet
            return UIViewController()
        }
    }
}
