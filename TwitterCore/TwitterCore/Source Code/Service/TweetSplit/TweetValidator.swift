//
//  TweetValidator.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

class TweetValidator {

    func validate(_ message: String) -> SplitError? {
        if message.isEmpty {
            return .invalid
        }
        return nil
    }
}
