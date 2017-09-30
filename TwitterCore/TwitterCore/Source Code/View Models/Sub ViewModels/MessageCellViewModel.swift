//
//  MessageCellViewModel.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

// MARK: - MessageCellPresentable
/// MessageCellPresentable is the protocol which defind all data need to exposed to the real world (UI app)
/// Instead of exposing all of model class (UserObj, MessageObj, ...)
/// We defind which property we REALLY want to show on screen
//
/// Respect The Interface Segregation in SOLID principle
///
public protocol MessageCellPresentable {

    var message: String { get }
    var userName: String { get }
    var avatar: String { get }
    var date: Date { get }
}

// MARK: - MessageCellViewModel
public class MessageCellViewModel: MessageCellPresentable {

    // MARK: - Internal
    fileprivate let messageObj: MessageObj

    // MARK: - MessageCellPresentable
    public var message: String { return self.messageObj.tweet.text }
    public var userName: String { return self.messageObj.user.name }
    public var avatar: String { return self.messageObj.user.avatar }
    public var date: Date { return self.messageObj.createdAt }

    // MARK: - Init
    init(messageObj: MessageObj) {
        self.messageObj = messageObj
    }


    /// Convenience initalization
    /// Create MessageObj with current User
    /// - Parameter tweetObj: TweetObj
    convenience init(tweetObj: TweetObj) {
        let message = MessageObj(user: TwitterAuth.default.currentUser,
                                 tweet: tweetObj)
        self.init(messageObj: message)
    }
}
