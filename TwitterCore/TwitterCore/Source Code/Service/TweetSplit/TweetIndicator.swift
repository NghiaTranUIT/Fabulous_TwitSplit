//
//  TweetIndicator.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation


/// <#Description#>
protocol TweetIndicatorProtocol {

    var index: Int { get }
    var total: Int { get }

    func toString() -> String
}


/// TweetPage represent the data of Indicator
/// Format: index/total
struct TweetIndicator: TweetIndicatorProtocol {

    /// The current Index
    let index: Int

    /// The total number of page
    var total: Int

    func toString() -> String {
        return "\(index)/\(total)"
    }
}
