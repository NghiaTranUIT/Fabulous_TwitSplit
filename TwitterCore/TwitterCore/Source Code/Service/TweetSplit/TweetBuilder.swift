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

    func add(_ newWord: String, indicator: TweetIndicator, isEnd: Bool) -> Bool {

        let nextCount = wordCount + newWord.count + indicator.toString(page).count
        let spaceCount = 1 + wordStacks.count

        guard nextCount + spaceCount <= 50 else {
            return false
        }

        // Add to stack
        wordStacks.append(newWord)
        wordCount += newWord.count

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
        var page = TweetPage(index: 1, max: 1)
        var currentPage = 1
        var currentComponent = TweetComponent(page: page)

        var i = 0
        while i < words.count {

            let word = words[i]
            let isEnd = i == (words.count - 1)
            let isAdded = currentComponent.add(word, indicator: indicator, isEnd: isEnd)
            if isAdded == false {

                // Add new component
                components.append(currentComponent)
                currentPage += 1

                // Reset
                page = TweetPage(index: currentPage, max: 0)
                currentComponent = TweetComponent(page: page)
            }
            else {
                i += 1
            }
        }

        // Add last one
        components.append(currentComponent)

        // Build
        let tweets = components.map { (component) -> TweetObj in
            component.updateMaxPage(currentPage)
            return component.build()
        }

        return SplitResult.init(rawValue: tweets)!
    }
}
