//
//  DefaultTweetConfiguration.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/29/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
@testable import TwitterCore

struct TweetDefaultConfiguration: TweetConfigurable {

    public let maxTweetCharacterCount = 50
    public let characterSet = CharacterSet.whitespacesAndNewlines

    static let `default` = TweetDefaultConfiguration()
}
