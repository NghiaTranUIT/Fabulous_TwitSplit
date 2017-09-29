//
//  TweetSplitProcessor.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

class TweetSplitProcessor {

    fileprivate let configuration: TweetConfigurable
    fileprivate let indicator: TweetIndicatorProtocol
    fileprivate let extractor: TweetExtractorProtocol
    fileprivate let validator: TweetValidatorProtocol

    // MARK: - Init
    init(indicator: TweetIndicatorProtocol,
         extractor: TweetExtractorProtocol,
         validator: TweetValidatorProtocol,
         configuration: TweetConfigurable) {
        self.indicator = indicator
        self.extractor = extractor
        self.validator = validator
        self.configuration = configuration
    }

    init() {
        self.configuration = TweetConfiguration()
        self.indicator = TweetIndicator(index: 0, total: 0)
        self.extractor = TweetExtractor(configurable: self.configuration)
        self.validator = TweetValidator()
    }

    func process(_ message: String) -> SplitResult {

        // Trim
        let message = message.trim()

        // Validate
        if let error = validator.validateEmptyMessage(message) {
            return .error(error)
        }

        // If meet requirement -> Length message is lesser than Max
        // Return
        if message.count < configuration.maxTweetCharacterCount {
            return .success([TweetObj(text: message)])
        }

        // Split and build appropriate Tweet Message
        return buildTweet(with: message)
    }
}

// MARK: - Private
extension TweetSplitProcessor {

    fileprivate func buildTweet(with message: String) -> SplitResult {

        // Extract to each word
        let words = extractor.extract(message)

        // Validate
        if let error = validator.validateWordExcessMaximumCount(words,
                                                                max: configuration.maxTweetCharacterCount) {
            return .error(error)
        }

        // Build Tweet
        let builder = TweetBuilder(words: words,
                                   indicator: indicator,
                                   configuration: configuration)
        return builder.build()
    }
}
