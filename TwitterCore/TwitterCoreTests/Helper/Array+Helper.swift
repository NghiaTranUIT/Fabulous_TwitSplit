//
//  Array+Helper.swift
//  TwitterCoreTests
//
//  Created by Nghia Tran on 9/29/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
@testable import TwitterCore

extension Array where Element == TweetObj {

    func mapToString() -> [String] {
        return self.map{ (i) -> String in
            return i.text
        }
    }
}

extension Array where Element == String {

    func isExcessTheMaximum(_ max: Int) -> Bool {
        return self.filter { $0.count > max }.isEmpty
    }
}
