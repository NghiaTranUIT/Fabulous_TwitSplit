//
//  MessageObj.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

class MessageObj {

    // MARK: - Variable
    public let user: UserObj
    public let tweet: TweetObj
    public let createdAt = Date()

    // MARK: - Init
    init(user: UserObj, tweet: TweetObj) {
        self.user = user
        self.tweet = tweet
    }
}
