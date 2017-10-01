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
    fileprivate var wordStacks: LinkedList<String>

    /// Current word count
    fileprivate var wordCount: Int

    /// Current Indicator
    fileprivate var indicator: TweetIndicatorProtocol

    // MARK: - Init
    init(indicator: TweetIndicatorProtocol, wordStacks: [String] = []) {
        self.indicator = indicator
        self.wordStacks = LinkedList<String>(wordStacks) // Build LinkedList from [String]
        self.wordCount = wordStacks.map { $0.count }.reduce(0, +) // Sum all word's count
    }

    // MARK: - Functions

    /// Append new word into current Stack
    /// Time complexity = O(1) due to the benefit of internal LinkedList
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

        // Add
        // As wordStacks is built from LinkedList<T>
        // This append function's time complexity is O(1) in general scenarios
        wordStacks.append(newWord)
        wordCount += newWord.count

        return false
    }

    /// Build TweetObj from TweetComponent
    /// Time complexity = O(n)
    ///
    /// - Returns: TweetObj
    func build() -> TweetObj {

        // Map wordStack into [String]
        let words = wordStacks.map { $0.value }
        
        // Append at begin
        let allWords = [indicator.toString()] + words

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
