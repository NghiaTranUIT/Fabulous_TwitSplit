//
//  TwitterService.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
import RxSwift

class TwitterService {

    // MARK: - Processor
    fileprivate let splitProcessor: TweetSplitProcessor

    // MARK: - Init
    init(splitProcessor: TweetSplitProcessor) {
        self.splitProcessor = splitProcessor
    }

    init() {
        self.splitProcessor = TweetSplitProcessor()
    }

    func splitMessage(_ rawMessage: String) -> SplitResult {
        return splitProcessor.process(rawMessage)
    }

    func splitMessageObserver(_ rawMessage: String) -> Observable<SplitResult> {

        return Observable.create {[unowned self] (observer) -> Disposable in

            // Process
            let result = self.splitProcessor.process(rawMessage)

            // Pass on next data
            // We don't need to onComplete or onError
            // Because we need to keep a signal alive until the DisposeBag is destroied
            observer.onNext(result)

            // Return
            return Disposables.create()
        }
    }
}
