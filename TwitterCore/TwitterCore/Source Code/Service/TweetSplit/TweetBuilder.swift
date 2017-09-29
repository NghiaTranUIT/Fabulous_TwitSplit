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
    fileprivate var indicator: TweetIndicatorProtocol
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
    func build() -> SplitResult {

        let result = processTweetComponents()
        let components = result.0
        let totalPage = result.1
        
        let tweets = components.map { (component) -> TweetObj in
            component.updateTotalPage(totalPage)
            return component.build()
        }

        // Check to re-build if need
        // In tough scenario, the length of total page in Indicator is too large
        // It causes a increase of total character of Tweet in order to break to MaximumCharacter Rule
        let toughCase = tweets.filter { $0.text.count > configuration.maxTweetCharacterCount }
        if toughCase.count > 0 {

            let result = processTweetComponents(totalPage)
            let components = result.0
            let totalPage = result.1

            let tweets = components.map { (component) -> TweetObj in
                component.updateTotalPage(totalPage)
                return component.build()
            }

            return .success(tweets)
        }


        // Success
        return .success(tweets)
    }

    fileprivate func processTweetComponents(_ totalPage: Int = 1) -> ([TweetComponent], Int) {

        // Prepare
        var components: [TweetComponent] = []
        var currentPage = 1
        indicator.update(1, total: totalPage)
        var currentComponent = TweetComponent(indicator: indicator)

        // While loop
        // After careful consideration, I prefer linear while loop instead of Recursive function
        // Because both have same Time Complexity
        // It's O(n)

        // The noticed drawback of recursive function is hard for reading and testing in few scenarios
        //

        // Furthermore, While-loop is self-explanatory
        // However, it seem to be slow a little bit when the number of tweets grow up
        // We could refactor TweetComponent's wordStacks by using LinkedList rather than ordinary Array
        // In general situation, it's reasonable.
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
                indicator.update(currentPage, total: totalPage)
                currentComponent = TweetComponent(indicator: indicator)
                continue
            }

            // Increase by 1
            i += 1
        }

        // Add last one
        components.append(currentComponent)

        return (components, currentPage)
    }
}
