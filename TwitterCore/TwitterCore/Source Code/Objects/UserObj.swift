//
//  UserObj.swift
//  TwitterCore
//
//  Created by Nghia Tran on 9/28/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

public class UserObj {

    // MARK: - Variable
    public let name: String
    public let avatar: String

    // MARK: - Init
    init(name: String) {
        self.name = name
        avatar = "placeholder"
    }
}
