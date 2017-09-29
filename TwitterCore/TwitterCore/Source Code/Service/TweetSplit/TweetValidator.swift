//
//  TweetValidator.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

// MARK: - TweetValidatorProtocol
// Represent all rules in order to validate the tweet
protocol TweetValidatorProtocol {


    /// Check whenever the message is empty
    ///
    /// - Parameter message: Message Text
    /// - Returns: Validate Error
    func validateEmptyMessage(_ message: String) -> ValidateError?


    /// Check if there is any non-space-word has length greater than the limit
    ///
    /// - Parameters:
    ///   - word: Array of words
    ///   - max: The maximum count of each Tweet
    /// - Returns: Validate Error
    func validateWordExcessMaximumCount(_ words: [String], max: Int) -> ValidateError?
}


// MARK: - TweetValidator
struct TweetValidator: TweetValidatorProtocol {

    func validateEmptyMessage(_ message: String) -> ValidateError? {

        // Is Empty
        if message.isEmpty {
            return .invalid
        }

        return nil
    }

    func validateWordExcessMaximumCount(_ words: [String], max: Int) -> ValidateError? {

        // Find if there is any one is
        guard words.first(where: {$0.count > max}) == nil else {
            return .wordLengthExcess
        }

        return nil
    }
}
