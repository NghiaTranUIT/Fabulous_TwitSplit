//
//  String+Trim.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/29/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

extension String {

    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
