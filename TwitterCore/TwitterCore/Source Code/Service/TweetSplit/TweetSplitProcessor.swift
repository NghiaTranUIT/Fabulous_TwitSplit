//
//  TweetSplitProcessor.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

/// TweetSplitProcessor is responsible for building list of appropriate Tweet
/// It's designed for customizable
/// Such as Configuration, Indicator, Extractor, Validator, ...
class TweetSplitProcessor {

    // MARK: - Variable
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

    // MARK: - Default
    init() {
        self.configuration = TweetConfiguration()
        self.indicator = TweetIndicator(index: 0, total: 0)
        self.extractor = TweetExtractor(configurable: self.configuration)
        self.validator = TweetValidator()
    }

    /// Main Process function.
    /// Take various setting (Indicator, Extractor, Validator) in order to build appropriately Tweet
    ///
    /// - Parameter message: Original message from user's input
    /// - Returns: SplitResult enum
    func process(_ message: String) -> SplitResult {

        // Trim
        let message = message.trim()

        // Validate
        if let error = validator.validateEmptyMessage(message) {
            return .error(error)
        }

        // If lengh of message is lesser than the maximum count -> Just return
        if message.count < configuration.maxTweetCharacterCount {
            return .success([TweetObj(text: message)])
        }

        // Split and build appropriate Tweet Message
        return buildTweet(with: message)
    }
}

// MARK: - Private
extension TweetSplitProcessor {

    /// Extract and Build Tweet
    ///
    /// - Parameter message: The Original Message from user's input
    /// - Returns: Split Result
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
