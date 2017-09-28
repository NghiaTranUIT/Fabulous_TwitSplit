//
//  TweetIndicator.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

struct TweetPage {

    let index: Int
    var max: Int

    func toString() -> String {
        return "\(index)/\(max)"
    }
}

final class TweetIndicator {

    func toString(_ page: TweetPage) -> String {
        return "\(page.index)/\(page.max)"
    }
}
