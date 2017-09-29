//
//  SplitResult.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

enum SplitResult {

    typealias T = [TweetObj]

    // Case
    case success(T)
    case error(ValidateError)

    public init?(rawValue: T) {
        self = .success(rawValue)
    }

    public init(errorValue: ValidateError) {
        self = .error(errorValue)
    }

    public var rawValue: T {
        switch self {
        case .success(let data):
            return data
        default:
            // There is no way return ERROR which corresponse with <T>
            fatalError("There is no way return ERROR which corresponse with <T>")
        }
    }

    // MARK: - Public
    public var isSucces: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }

    public var isError: Bool {
        switch self {
        case .error:
            return true
        default:
            return false
        }
    }

    public var result: T? {
        switch self {
        case .success(let data):
            return data
        default:
            return nil
        }
    }

    public var error: ValidateError? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
}
