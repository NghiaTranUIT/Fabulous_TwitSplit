//
//  FakeTweetIndicator.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/29/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
@testable import TwitterCore

struct SplashTweetIndicator: TweetIndicatorProtocol {

    var index: Int
    var total: Int

    func toString() -> String {
        return "\(index)/\(total)"
    }
}
