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
class LinkedList<T> {

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

    /// Default Initialization
    init() {}

    /// Alternative Initialization from any Sequence which same type of Element
    /// It could be an array or other data structure which apdopted Sequence protocol
    ///
    /// - Parameter elements: Sequence elements
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
        self.tail = node
        count += 1
    }
}

// MARK: - Helper
extension LinkedList {

    func mapToArray() -> [T] {
        return map { $0.value }
    }

    /// Simple Map function
    ///
    /// - Parameter block: Map Block
    /// - Returns: Array of desired value
    public func map<E>(_ block: (Node<NodeType>) -> E) -> [E] {

        // Initial
        var result: [E] = []

        // Iterate and map all of nodes
        // then transforming to desired value
        // Time complexity = O(n)
        forEach { result.append(block($0)) }

        // Return
        return result
    }

    public func forEach(_ block: (Node<NodeType>) -> Void) {

        // Iterate all of nodes
        // Time complexity = O(n)
        var currentPointer = head
        while currentPointer != nil {

            // Exec
            block(currentPointer!)

            // Next
            currentPointer = currentPointer?.next
        }
    }
}
