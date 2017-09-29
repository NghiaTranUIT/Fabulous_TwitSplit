//
//  SplitConfiguration.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

protocol TweetConfigurable {

    var maxTweetCharacterCount: Int { get }
    var characterSet: CharacterSet { get }
}

struct TweetConfiguration: TweetConfigurable {

    public let maxTweetCharacterCount = 50
    public let characterSet = CharacterSet.whitespacesAndNewlines
}
