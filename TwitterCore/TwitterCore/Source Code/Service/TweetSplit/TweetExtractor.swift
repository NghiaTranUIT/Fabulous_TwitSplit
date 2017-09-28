//
//  TweetExtractor.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

class TweetExtractor {

    // MARK: - Variable
    fileprivate let characterExtractor: CharacterSet

    // MARK: - Init
    init(characterExtractor: CharacterSet = CharacterSet.whitespaces) {
        self.characterExtractor = characterExtractor
    }

    func extract(_ message: String) -> [String] {
        return message.components(separatedBy: characterExtractor)
    }
}
