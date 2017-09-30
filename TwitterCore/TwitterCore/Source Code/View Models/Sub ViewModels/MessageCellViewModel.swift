//
//  MessageCellViewModel.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

protocol MessageCellPresentable {

    var message: String { get }
    var userName: String { get }
    var avatar: String { get }
    var date: Date { get }
}

public class MessageCellViewModel: MessageCellPresentable {

    // MARK: - Internal
    fileprivate let messageObj: MessageObj

    // MARK: - MessageCellPresentable
    var message: String { return self.messageObj.tweet.text }
    var userName: String { return self.messageObj.user.name }
    var avatar: String { return self.messageObj.user.avatar }
    var date: Date { return self.messageObj.createdAt }

    // MARK: - Init
    init(messageObj: MessageObj) {
        self.messageObj = messageObj
    }

    convenience init(tweetObj: TweetObj) {
        let message = MessageObj(user: TwitterAuth.default.currentUser,
                                 tweet: tweetObj)
        self.init(messageObj: message)
    }
}
