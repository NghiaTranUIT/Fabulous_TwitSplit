//
//  SplitConfiguration.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

/// Generic configruation for TweetSpltProcessor
protocol TweetConfigurable {

    /// The Maximum lenght of Tweet could be allowed
    var maxTweetCharacterCount: Int { get }

    /// CharacterSet for extractor
    var characterSet: CharacterSet { get }
}

/// Desired configration
struct TweetConfiguration: TweetConfigurable {

    public let maxTweetCharacterCount = 50
    public let characterSet = CharacterSet.whitespacesAndNewlines
}
