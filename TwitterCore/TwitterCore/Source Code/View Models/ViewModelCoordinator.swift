//
//  ViewModelCoordinator.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

public protocol ViewModelCoordinatorProtocol {

    var appViewModel: AppViewModelProtocol { get }
    var twitterViewModel: TwitterViewModel { get }
}

/// ViewModelCoordinator is responsible for coordinating all of ViewModel in TwitterCore framework
/// In conjuntion with ControllerRouter in order to setup an appropriate ViewModel
///
public final class ViewModelCoordinator: ViewModelCoordinatorProtocol {

    // MARK: - View models
    public let appViewModel: AppViewModelProtocol
    public let twitterViewModel: TwitterViewModel

    // MARK: - Init
    init(appViewModel: AppViewModelProtocol,
         twitterViewModel: TwitterViewModel) {

        self.appViewModel = appViewModel
        self.twitterViewModel = twitterViewModel
    }

    /// Default implementation for TwitterApp
    ///
    /// - Returns: ViewModelCoordinator instance
    public class func defaultApp() -> ViewModelCoordinator {

        // Service
        let twitterService = TwitterService()

        // View model
        let appViewModel = AppViewModel()
        let twitterViewModel = TwitterViewModel(twitterService: twitterService)


        // Init
        return ViewModelCoordinator(appViewModel: appViewModel,
                                    twitterViewModel: twitterViewModel)
    }
}
