//
//  TwitterViewModel.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public protocol TwitterViewModelProtocol {

    var input: TwitterViewModelInput { get }
    var output: TwitterViewModelOutput { get }
}

public protocol TwitterViewModelInput {

    var sendMessagePublish: PublishSubject<String> { get }
}

public protocol TwitterViewModelOutput {

    var tweetsDriver: Driver<Result<[MessageCellViewModel], ValidateError>> { get }
}

public class TwitterViewModel: TwitterViewModelProtocol, TwitterViewModelInput, TwitterViewModelOutput {

    // MARK: - View Model
    public var input: TwitterViewModelInput { return self }
    public var output: TwitterViewModelOutput { return self }

    // MARK: - Variable
    fileprivate let twitterService: TwitterService

    // MARK: - Input
    public var sendMessagePublish = PublishSubject<String>()

    // MARK: - Output
    public var tweetsDriver: Driver<Result<[MessageCellViewModel], ValidateError>>

    // MARK: - Init
    init(twitterService: TwitterService) {
        self.twitterService = twitterService

        // Handl
        self.tweetsDriver = sendMessagePublish
            .asObserver()
            .flatMapLatest { (message) -> Observable<SplitResult> in

                //
                // Process Tweet content by using TwitterService
                //
                return twitterService.splitMessageObserver(message)
            }
            .map { splitResult -> Result<[MessageCellViewModel], ValidateError> in
                switch splitResult {
                case .error(let error):

                    // Just pass error
                    return Result.error(error)

                case .success(let tweets):

                    //
                    // Map from TweetObj to MessageCellViewModel (which adopted MessageCellPresentor)
                    // Because we shouldn't expose the core of Twitter to the UI app
                    // In this scenario, it's all of Model Objects (UserObj, MessageObj, TweetObj, ...)
                    //
                    // As a result, the UI app is no dependency on which conrete model inside the TwitterCore anymore
                    // It's high flexibility if we change the models in the future -> don't need to fix on UI app
                    //
                    let viewModels = tweets.map { MessageCellViewModel(tweetObj: $0) }
                    return Result.success(viewModels)
                }

            }
            // If error, just return ValidateError.invalid
            .asDriver(onErrorJustReturn: Result<[MessageCellViewModel], ValidateError>.error(ValidateError.invalid))
    }
}
