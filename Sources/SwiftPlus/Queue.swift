//
//  Queue.swift
//  Created by Vladyslav Yerofieiev on 14.10.2020.
//  Copyright © 2020 MorayGames. All rights reserved.
//

import Foundation

/// Canonical LIFO Queue
public struct Queue<Element> {
    private var data: LinkedList<Element> = []
    
    // MARK: - Initializers
    public init() { }
    
    /// Initialize
    /// - Parameter elements:  Elements list
    /// - Complexity: O(*m*) on average, where *m* is the length of
    ///   `objects`
    public init<S: Sequence>(_ elements: S) where Element == S.Element {
        elements.forEach { enqueue($0) }
    }
    
    // MARK: - Modifications
    
    /// Add new element to queue
    /// - Parameter object: Element
    /// - Complexity: O(1) on average, over many calls to `enqueue(_:)` on the
    ///   same queue.
    public mutating func enqueue(_ object: Element) {
        data.addLast(object)
    }
    
    /// Insert elements to queue
    /// - Parameter objects: Elements list
    /// - Complexity: O(*m*) on average, where *m* is the length of
    ///   `objects`, over many calls to `enqueue(contentsOf:)` on the same
    ///   queue.
    public mutating func enqueue<S: Sequence>(contentsOf objects: S) where Element == S.Element {
        objects.forEach { enqueue($0) }
    }
    
    /// Removes and returns the top element of the collection.
    /// - Returns: The top element of the collection if the collection is not
    /// empty; otherwise, `nil`.
    ///
    /// - Complexity: O(1)
    public mutating func dequeue() -> Element? {
        return data.pollFirst()
    }
    
    /// Remove all values from the queue.
    public mutating func clearAll() {
        data.clearAll()
    }

    /// The top element of the collection if the collection is not
    /// empty; otherwise, `nil`.
    public var top: Element? {
        return data.last
    }
    
    /// Check if object exist in queue
    /// - Parameter object: Object
    /// - Returns: `true` if object exist, otherwise `false`
    public func isExist(_ object: Element) -> Bool where Element: Equatable {
       return data.indexFromEnd(of: object) != nil
    }
}


extension Queue: Sequence {
}

extension Queue: CustomStringConvertible {
    /// A textual representation of the queue and its elements.
    public var description: String {
        return "[" + self.data.map { "\($0)" }.joined(separator: " ← ") + "]"
    }
}

extension Queue: IteratorProtocol {
    /// Advance to the next element and return it, or `nil` if no next
    /// element exists.
    public mutating func next() -> Element? {
        return dequeue()
    }
}

extension Queue {
    // A Boolean value indicating whether the collection is empty.
    ///
    /// When you need to check whether your collection is empty, use the
    /// `isEmpty` property instead of checking that the `count` property is
    /// equal to zero. For collections that don't conform to
    /// `RandomAccessCollection`, accessing the `count` property iterates
    /// through the elements of the collection.
    ///
    ///     let horseName = "Silver"
    ///     if horseName.isEmpty {
    ///         print("I've been through the desert on a horse with no name.")
    ///     } else {
    ///         print("Hi ho, \(horseName)!")
    ///     }
    ///     // Prints "Hi ho, Silver!")
    ///
    /// - Complexity: O(1)
    public var isEmpty: Bool {
        data.isEmpty
    }
    
    /// The number of elements in the queue.
    public var count: Int {
        return data.count
    }
}

extension Queue: ExpressibleByArrayLiteral {
    /// Init with literals
    /// - Parameter elements: element
    public init(arrayLiteral elements: Element...) {
        elements.forEach { self.enqueue($0) }
    }
    
    public typealias ArrayLiteralElement = Element    
}
