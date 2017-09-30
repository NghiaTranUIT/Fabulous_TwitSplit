//
//  Identifier.swift
//  TwitterApp
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Identitifer protocol
protocol Identifier {

    // Static vartiable to get id of object
    static var identifier: String {get}
}

// MARK: - Exntension
extension Identifier {

    static var identifier: String {
        return String(describing: self)
    }
}

// MARK: - Conform automatically
extension UIViewController: Identifier {}
extension UIView: Identifier {}

