//
//  Node.swift
//  TwitterCore
//
//  Created by Nghia Tran on 10/1/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

/// Node<T> represent the note of LinkedList<T>
class Node<T> {

    // MARK: - Variable
    public let value: T

    /// Next node pointer
    /// It could be nil
    public var next: Node<T>? = nil

    // MARK: - Init
    init(value: T) {
        self.value = value
    }
}
