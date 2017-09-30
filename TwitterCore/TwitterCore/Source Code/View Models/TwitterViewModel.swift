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

    var tweetsDriver: Driver<Result<[MessageCellViewModel]>> { get }
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
    public var tweetsDriver: Driver<Result<[MessageCellViewModel]>>

    // MARK: - Init
    init(twitterService: TwitterService) {
        self.twitterService = twitterService

        // Binding
        self.tweetsDriver = sendMessagePublish
            .asObserver()
            .flatMapLatest { (message) -> Observable<SplitResult> in
                return twitterService.splitMessageObserver(message)
            }
            .map { splitResult -> Result<[MessageCellViewModel]> in
                switch splitResult {
                case .error(let error):
                    return Result.error(error)
                case .success(let tweets):
                    let viewModels = tweets.map { MessageCellViewModel(tweetObj: $0) }
                    return Result.success(viewModels)
                }

            }
            .asDriver(onErrorJustReturn: Result<[MessageCellViewModel]>.success([]))
    }
}
