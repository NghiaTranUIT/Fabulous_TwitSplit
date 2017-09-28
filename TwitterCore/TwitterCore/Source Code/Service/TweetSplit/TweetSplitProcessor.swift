//
//  TweetSplitProcessor.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

class TweetSplitProcessor {

    fileprivate let configuration: SplitConfiguration
    fileprivate let indicator: TweetIndicator
    fileprivate let extractor: TweetExtractor
    fileprivate let validator: TweetValidator

    // MARK: - Init
    init(indicator: TweetIndicator,
         extractor: TweetExtractor,
         validator: TweetValidator,
         configuration: SplitConfiguration = SplitConfiguration()) {
        self.indicator = indicator
        self.extractor = extractor
        self.validator = validator
        self.configuration = configuration
    }

    func process(_ message: String) -> SplitResult {

        // Validate
        if let error = validator.validate(message) {
            return SplitResult.error(error)
        }

        // Extract to each word
        let words = extractor.extract(message)

        // Build Tweet
        let builder = TweetBuilder(indicator: indicator, words: words, configuration: configuration)
        return builder.process()
    }
}
