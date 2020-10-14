//
//  Stack.swift
//  Created by Vladyslav Yerofieiev on 14.10.2020.
//  Copyright © 2020 MorayGames. All rights reserved.
//

import Foundation

/// Canonical FIFO  stack
public struct Stack<Element> {
    private var data: [Element] = []
    
    /// Initialize
    /// - Parameter elements:  Elements list
    /// - Complexity: O(*m*) on average, where *m* is the length of
    ///   `objects`
    public init<S: Sequence>(_ elements: S) where Element == S.Element {
        push(contentsOf: elements)
    }
    
    // MARK: - Modifications
    
    /// Add new element to stack
    /// - Parameter object: Element
    /// - Complexity: O(1) on average, over many calls to `enqueue(_:)` on the
    ///   same stack.
    public mutating func push(_ object: Element) {
        data.append(object)
    }
    
    /// Insert elements to stack
    /// - Parameter objects: Elements list
    /// - Complexity: O(*m*) on average, where *m* is the length of
    ///   `objects`, over many calls to `push(contentsOf:)` on the same
    ///   stack.
    public mutating func push<S: Sequence>(contentsOf objects: S) where Element == S.Element {
        objects.forEach { push($0) }
    }
    
    /// Removes and returns the top element of the collection.
    /// - Returns: The top element of the collection if the collection is not
    /// empty; otherwise, `nil`.
    ///
    /// - Complexity: O(1)
    public mutating func pop() -> Element? {
        return data.popLast()
    }
    
    /// Remove all values from the stack.
    public mutating func clearAll() {
        data.removeAll()
    }

    /// The top element of the collection if the collection is not
    /// empty; otherwise, `nil`.
    public var top: Element? {
        return data.last
    }
    
    /// Check if object exist in stack
    /// - Parameter object: Object
    /// - Returns: `true` if object exist, otherwise `false`
    public func isExist(_ object: Element) -> Bool where Element: Equatable {
       return data.firstIndex(of: object) != nil
    }
}


extension Stack: Sequence {
}

extension Stack: CustomStringConvertible {
    /// A textual representation of the stack and its elements.
    public var description: String {
        return "[" + self.data.reversed().map { "\($0)" }.joined(separator: " → ") + "]"
    }
}

extension Stack: IteratorProtocol {
    /// Advance to the next element and return it, or `nil` if no next
    /// element exists.
    public mutating func next() -> Element? {
        return pop()
    }
}

extension Stack {
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
    
    /// The number of elements in the stack.
    public var count: Int {
        return data.count
    }
}

extension Stack: ExpressibleByArrayLiteral {
    /// Init with literals
    /// - Parameter elements: element
    public init(arrayLiteral elements: Element...) {
        push(contentsOf: elements)
    }
    
    public typealias ArrayLiteralElement = Element    
}
