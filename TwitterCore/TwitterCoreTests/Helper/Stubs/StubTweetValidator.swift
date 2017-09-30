//
//  StubTweetValidator.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/29/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
@testable import TwitterCore

struct StubTweetValidator: TweetValidatorProtocol {

    func validateEmptyMessage(_ message: String) -> ValidateError? {
        return nil
    }

    func validateWordExcessMaximumCount(_ words: [String], max: Int) -> ValidateError? {
        return nil
    }
}
