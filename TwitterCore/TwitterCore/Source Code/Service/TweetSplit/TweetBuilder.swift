//
//  TweetBuilder.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

class TweetComponent {

    fileprivate var wordStacks: [String] = []
    fileprivate var wordCount = 0
    fileprivate var page: TweetPage

    init(page: TweetPage) {
        self.page = page
    }

    func updateMaxPage(_ max: Int) {
        page.max = max
    }

    func add(_ newWord: String, indicator: TweetIndicator) -> Bool {

        let nextCount = wordCount + newWord.count + indicator.toString(page).count

        guard nextCount <= 50 else {
            return false
        }

        // Add to stack
        wordStacks.append(newWord)
        return true
    }

    func build() -> TweetObj {

        // Append at begin
        let allWords = [page.toString()] + wordStacks

        // Create sentences
        let content = allWords.joined(separator: " ")

        // Return obj
        return TweetObj(text: content)
    }
}

class TweetBuilder {

    // MARK: - Variable
    fileprivate let configuration: SplitConfiguration
    fileprivate let indicator: TweetIndicator
    fileprivate let words: [String] 

    init(indicator: TweetIndicator, words: [String], configuration: SplitConfiguration) {
        self.indicator = indicator
        self.words = words
        self.configuration = configuration
    }

    func process() -> SplitResult {

        var components: [TweetComponent] = []
        var page = TweetPage(index: 0, max: 0)
        var currentComponent = TweetComponent(page: page)

        words
            .enumerated()
            .forEach { (i, word) in

                let isExcess = currentComponent.add(word, indicator: indicator)
                if isExcess {

                    // Add new component
                    components.append(currentComponent)

                    // Reset
                    page = TweetPage(index: page.index + 1, max: 0)
                    currentComponent = TweetComponent(page: page)
                }
        }

        // Build
        let tweets = components.map { (component) -> TweetObj in
            component.updateMaxPage(page.index)
            return component.build()
        }

        return SplitResult.init(rawValue: tweets)!
    }
}
