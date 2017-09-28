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
    fileprivate let configuration: SplitConfiguration
    fileprivate let indicator: TweetIndicator
    fileprivate let words: [String] 

    init(indicator: TweetIndicator, words: [String], configuration: SplitConfiguration) {
        self.indicator = indicator
        self.words = words
        self.configuration = configuration
    }

    func process() -> SplitResult {
        return SplitResult.init(rawValue: [])!
    }
}
