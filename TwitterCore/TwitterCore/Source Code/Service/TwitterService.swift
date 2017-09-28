//
//  TwitterService.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

class TwitterService {

    // MARK: - Processor
    fileprivate let splitProcessor: TweetSplitProcessor

    // MARK: - Init
    init(splitProcessor: TweetSplitProcessor = TweetSplitProcessor()) {
        self.splitProcessor = splitProcessor
    }

    func processRawMessage(rawMessage: String) -> SplitResult {
        return splitProcessor.process(rawMessage)
    }
}
