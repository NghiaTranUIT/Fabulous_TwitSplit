//
//  TwitterAuth.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

public class TwitterAuth {

    // MARK: - Variable
    fileprivate let _internalUser = UserObj(name: "Nghia Tran")

    // MARK: - Current
    static let `default` = TwitterAuth()

    // Current User
    // Because the requirement of TwitSplit isn't relevant to authentication mechanism
    // => Just temporary
    public var currentUser: UserObj { return _internalUser }

}
