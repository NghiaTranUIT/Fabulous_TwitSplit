//
//  StubTweetIndicator.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
@testable import TwitterCore

struct StubTweetIndicator: TweetIndicatorProtocol {

    var index: Int = 0
    var total: Int = 0

    func toString() -> String {
        return ""
    }
}
