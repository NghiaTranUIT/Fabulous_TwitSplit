//
//  Result.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

public enum Result<T, E: Error> {

    public typealias ValueType = T
    public typealias ErrorType = E

    // Case
    case success(ValueType)
    case error(ErrorType)

    public var rawValue: ValueType {
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

    public var result: ValueType? {
        switch self {
        case .success(let data):
            return data
        default:
            return nil
        }
    }

    public var error: ErrorType? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
}
