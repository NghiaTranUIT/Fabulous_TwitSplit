//
//  TweetComponent.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/29/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

/// TweetComponent is a queue which represents the Tweet message
/// It contains wordStacks, wordCount and page
/// Convenience for building TweetObj
class TweetComponent {

    // MARK: - Variable

    /// Contain array of words
    fileprivate var wordStacks: [String] = []

    /// Current word count
    fileprivate var wordCount = 0

    /// Current Indicator
    fileprivate var indicator: TweetIndicator

    // MARK: - Init
    init(indicator: TweetIndicator) {
        self.indicator = indicator
    }

    // MARK: - Functions

    /// Append new word into current Stack
    ///
    /// - Parameter newWord: New word
    /// - Returns: True: Excess the limit.
    func append(_ newWord: String, maxCount: Int) -> Bool {

        // Estimate the length of tweet
        let nextCount = indicator.toString().count + wordCount + newWord.count

        // Total space needed
        let spaceCount = 1 + wordStacks.count

        // If the length of tweet is excessed the limit
        // Return false and don't add to stack
        guard nextCount + spaceCount <= maxCount else {
            return true
        }

        // Add to stack
        wordStacks.append(newWord)
        wordCount += newWord.count

        return false
    }


    /// Build TweetObj from TweetComponent
    ///
    /// - Returns: TweetObj
    func build() -> TweetObj {

        // Append at begin
        let allWords = [indicator.toString()] + wordStacks

        // Create sentences
        let content = allWords.joined(separator: " ")

        // Return obj
        return TweetObj(text: content)
    }

    /// Update the max page.
    /// We don't really know the number of tweet in advance.
    /// It's necessary to re-update it again.
    ///
    /// - Parameter max: New Total Page
    func updateTotalPage(_ total: Int) {
        indicator.total = total
    }
}
