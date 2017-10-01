//
//  TweetBuilder.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

/// TweetBuildResult warp brief data
/// Only for internal usage
private struct TweetBuildResult {

    let components: [TweetComponent]
    let totalPage: Int
}

/// TweetBuilder
/// Build the whole message into chunk of Tweet components
class TweetBuilder {

    // MARK: - Variable
    fileprivate let configuration: TweetConfigurable
    fileprivate var indicator: TweetIndicatorProtocol
    fileprivate let words: [String] 
    fileprivate var maxCount: Int { return self.configuration.maxTweetCharacterCount }

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
    func build() -> SplitResult {

        // Process
        let result = processTweetComponents()
        var components = result.components

        // Check to re-build Tweet if need
        //
        // In tough scenario, the length of total page in Indicator is too large
        // It causes a increase of total character of Tweet in order to break to MaximumCharacter Rule
        // Ex: Please look at the README.md for further information
        //
        let needRebuilt = components.filter { $0.build().text.count > maxCount }.count > 0
        if needRebuilt {
            let totalPage = result.totalPage
            let result = processTweetComponents(totalPage)
            components = result.components
        }

        // Success
        let tweets = components.map { $0.build() }
        return .success(tweets)
    }
}

// MARK: - Private
extension TweetBuilder {


    /// Internal functional to split large message into pices of tweet components
    ///
    /// - Parameter totalPage: TotalPage. Default is 1
    /// - Returns: The TweetBuildResult represents an array of components and total page
    fileprivate func processTweetComponents(_ totalPage: Int = 1) -> TweetBuildResult {

        // Prepare
        let components = LinkedList<TweetComponent>([])
        var currentPage = 1

        //
        // TODO: Side effect here
        // This func modify the indicator variable outside
        // Need to find the elegant solution in future
        //
        indicator.update(1, total: totalPage)
        var currentComponent = TweetComponent(indicator: indicator)

        // While loop
        // After careful consideration, I prefer linear while loop instead of Recursive function
        // Time complexity in this situtation COULD be considered
        // as O(n) in general situations
        //
        // The noticed drawback of recursive function is hard for reading and testing in few scenarios
        //
        // Otherwise, While-loop is self-explanatory
        // All of computation in While-loop is O(1)
        // Because we use LinkedList<T> for all append functions
        //
        var i = 0
        while i < words.count {

            // Access time of array is O(1)
            let word = words[i]

            // Time Complexcity = O(1)
            // because the TweetComponent is using LinkedList as an internal storage.
            let isExcess = currentComponent.append(word,
                                                   maxCount: maxCount)

            // The tweet is excessed
            if isExcess {

                // Add new component
                // Time Complexity = O(1)
                // Because the components is LinkedList<TweetComponent>
                components.append(currentComponent)
                currentPage += 1

                // Reset
                indicator.update(currentPage, total: totalPage)
                currentComponent = TweetComponent(indicator: indicator)
                continue
            }

            // Increase by 1
            i += 1
        }

        // Add last one
        // Time = O(1)
        components.append(currentComponent)

        // Update total tweet again
        // Because we're unable to estimate how many tweet in total before processing
        // It's time to update page again
        // Time = O(n)
        components.forEach { $0.value.updateTotalPage(currentPage) }

        // Return
        return TweetBuildResult(components: components.mapToArray(),
                                totalPage: currentPage)
    }
}
