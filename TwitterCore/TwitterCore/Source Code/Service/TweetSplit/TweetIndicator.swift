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

    var index: Int { get set }
    var total: Int { get set }

    func toString() -> String
}

extension TweetIndicatorProtocol {

    mutating func update(_ index: Int, total: Int) {
        self.index = index
        self.total = total
    }
}

/// TweetPage represent the data of Indicator
/// Format: index/total
struct TweetIndicator: TweetIndicatorProtocol {

    /// The current Index
    var index: Int

    /// The total number of page
    var total: Int
    
    func toString() -> String {
        return "\(index)/\(total)"
    }
}
