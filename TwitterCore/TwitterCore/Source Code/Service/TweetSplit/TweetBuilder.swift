//
//  TweetBuilder.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

class TweetBuilder {

    // MARK: - Variable
    fileprivate let configuration: TweetConfigurable
    fileprivate let indicator: TweetIndicatorProtocol
    fileprivate let words: [String] 

    // MARK: - Init
    init(words: [String], indicator: TweetIndicatorProtocol, configuration: TweetConfigurable) {
        self.words = words
        self.indicator = indicator
        self.configuration = configuration
    }

    // MARK: - Func


    /// Main Tweet Split func goes here
    ///
    /// - Returns: The result
    func process() -> SplitResult {

        // Prepare
        var components: [TweetComponent] = []
        var page = TweetIndicator(index: 1, total: 1)
        var currentPage = 1
        var currentComponent = TweetComponent(indicator: page)

        // While
        // After careful consideration, I prefer linear while loop instead of Recursive function
        // Because both have same Time Complexity
        // It's O(n)

        // The noticed drawback of recursive function is hard for reading
        // Recursive func also depend heavily on the number of Stack which allow by the current iOS hardward
        //

        // Furthermore, While-loop is self-explanatory
        // However, it seem to be slow a little bit when the number of tweets grow up
        // We could refactor TweetComponent by using LinkedList rather than ordinary Array
        var i = 0
        while i < words.count {

            let word = words[i]
            let isExcess = currentComponent.append(word,
                                                  maxCount: configuration.maxTweetCharacterCount)

            // The tweet is excessed
            if isExcess {

                // Add new component
                components.append(currentComponent)
                currentPage += 1

                // Reset
                page = TweetIndicator(index: currentPage, total: 0)
                currentComponent = TweetComponent(indicator: page)
                continue
            }

            // Increase by 1
            i += 1
        }

        // Add last one
        components.append(currentComponent)

        // Map from TweetComponent -> TweetObj
        let tweets = components.map { (component) -> TweetObj in
            component.updateTotalPage(currentPage)
            return component.build()
        }

        // Success
        return .success(tweets)
    }
}
