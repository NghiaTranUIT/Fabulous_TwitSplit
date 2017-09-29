//
//  SplitError.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation


/// ValidateError represent all kind of Error when validating the tweet
///
/// - wordLengthExcess: If there is one word in message which is excessed the limit, and can't split to individual tweet.
/// - indicatorLengthExcesss: Indicator word is excessed the limit. For example: 1/1000000000000000... -> [more than 50 characters]
/// - invalid: All of remain invalid case
enum ValidateError: Error {

    case wordLengthExcess
    case indicatorLengthExcesss
    case invalid

    /// User-friendly Error message
    var localizedDescription: String {
        switch self {
        case .wordLengthExcess:
            return "There is one word couldn't be splited to individual Tweet"
        case .indicatorLengthExcesss:
            return "Indicator length excesses"
        case .invalid:
            return "Invalid Tweet"
        }
    }
}
