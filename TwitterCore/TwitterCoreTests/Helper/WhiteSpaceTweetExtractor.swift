//
//  FakeTweetExtractor.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/29/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
@testable import TwitterCore

struct WhiteSpaceTweetExtractor: TweetExtractorProtocol {

    /// Character Set for extractor
    var characterSet: CharacterSet { return .whitespaces }

    // Extract
    func extract(_ message: String) -> [String] {
        return message.components(separatedBy: characterSet)
    }
}
