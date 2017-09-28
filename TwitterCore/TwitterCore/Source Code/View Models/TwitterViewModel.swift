//
//  TwitterViewModel.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

public protocol TwitterViewModelProtocol {

    var input: TwitterViewModelInput { get }
    var output: TwitterViewModelOutput { get }
}

public protocol TwitterViewModelInput {

    func sendMessage(text: String)
}

public protocol TwitterViewModelOutput {

}

public class TwitterViewModel: TwitterViewModelProtocol, TwitterViewModelInput, TwitterViewModelOutput {

    // MARK: - View Model
    public var input: TwitterViewModelInput { return self }
    public var output: TwitterViewModelOutput { return self }

    // MARK: - Variable
    fileprivate let twitterService: TwitterService

    // MARK: - Input

    // MARK: - Output

    // MARK: - Init
    init(twitterService: TwitterService) {
        self.twitterService = twitterService
    }

    public func sendMessage(text: String) {
        let result = twitterService.processRawMessage(rawMessage: text)
        print(result)
    }
}
