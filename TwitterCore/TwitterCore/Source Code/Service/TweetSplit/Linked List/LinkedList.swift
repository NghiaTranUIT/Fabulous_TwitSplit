//
//  LinkedList.swift
//  TwitterCore
//
//  Created by Nghia Tran on 10/1/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation

/// Generic Linked List<T>
/// In order to reduce the time complexity when building "array of Tweet" to O(1)
/// Linked list is a best choice here
class LinkedList<T: Equatable> {

    /// Generic type
    typealias NodeType = T

    // MARK: - Variable
    public private(set) var head: Node<NodeType>? = nil {
        didSet {
            if tail == nil {
                tail = head
            }
        }
    }

    public private(set) var tail: Node<NodeType>? = nil {
        didSet {
            if head == nil {
                head = tail
            }
        }
    }

    /// Total Count
    public private(set) var count: Int = 0

    /// Is empty
    public var isEmpty: Bool { return self.count == 0}

    /// Lock
    private let _lock = NSLock()

    // MARK: - Init
    init() {}

    init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
        for item in elements {
            append(item)
        }
    }

    // MARK: - Public

    /// Append new value to the end of linked list
    /// Time complexity is O(1)
    ///
    /// - Parameter value: The raw value
    public func append(_ value: NodeType) {
        let node = Node(value: value)
        append(node)
    }

    /// Append new node to the end of linked list
    /// Time complexity is O(1)
    ///
    /// - Parameter node: The new node
    public func append(_ node: Node<NodeType>) {

        // Safe thread
        // count, tail and head are Critical Section
        // Avoid race condition
        _lock.lock()
        defer {
            _lock.unlock()
        }

        // If the linked list is empty
        // Assign new node as the Head node
        guard let tail = tail else {
            head = node
            count += 1
            return
        }

        // Otherwise, just assign it as an nextNode of tail node
        tail.next = node
        count += 1
    }
}
