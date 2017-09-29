//
//  TweetExtractor.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

/// TweetExtractorProtocol defind the common extraction
protocol TweetExtractorProtocol {

    /// Character Set for extractor
    var characterSet: CharacterSet { get }

    /// Extract function
    ///
    /// - Parameter message: The raw message needs to be extracts to each individual words
    /// - Returns: Array of words
    func extract(_ message: String) -> [String]
}

/// TweetExtractor
struct TweetExtractor: TweetExtractorProtocol {

    // MARK: - Variable
    fileprivate let configurable: TweetConfigurable
    var characterSet: CharacterSet { return configurable.characterSet }

    // MARK: - Init
    init(configurable: TweetConfigurable) {
        self.configurable = configurable
    }

    func extract(_ message: String) -> [String] {
        return message.components(separatedBy: characterSet)
    }
}
