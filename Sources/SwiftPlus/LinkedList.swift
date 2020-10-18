//
//  LinkedList.swift
//  Created by Vladyslav Yerofieiev on 14.10.2020.
//  Copyright © 2020 MorayGames. All rights reserved.
//

import Foundation

/// Linked List
public struct LinkedList<Element> {
    
    private class Entry<Element> {
        var element: Element
        weak var previous: Entry?
        var next: Entry?
        
        init(element: Element,
             previous: Entry? = nil,
             next: Entry? = nil) {
            self.element = element
            self.next = next
            self.previous = previous
        }
    }
    
    private var counter: Int = 0
    private var head: Entry<Element>? = nil
    private var tail: Entry<Element>? = nil
    
    /// Initialize
    /// - Parameter elements:  Elements list
    /// - Complexity: O(*m*) on average, where *m* is the length of
    ///   `objects`
    public init<S: Sequence>(_ elements: S) where Element == S.Element {
        addLast(contentOf: elements)
    }

    // MARK: - Add elements
    
    /// Inserts the specified element at the beginning of this list.
    /// - Parameter object: element
    /// - Complexity: O(1)
    public mutating func addFirst(_ object: Element) {
        let newElement = Entry(element: object)
        counter+=1
        guard let firstEntry = head else {
            head = newElement
            tail = head
            return
        }
        newElement.next = firstEntry
        head = newElement
    }
    
    /// Inserts the specified element one by one from objects list at the beginning of this list.
    /// - Parameter objects: objects list
    /// - Complexity: O(*m*) on average, where *m* is the length of
    ///   `objects`, over many calls to `addFirst(contentsOf:)` on the same
    ///   LinkedList.
    public mutating func addFirst<S: Sequence>(contentOf objects: S) where Element == S.Element {
        objects.forEach { addFirst($0) }
    }
    
    /// Appends the specified element to the end of this list.
    /// - Parameter object: element
    /// - Complexity: O(1)
    public mutating func addLast(_ object: Element) {
        guard let lastEntry = tail else {
            addFirst(object)
            return
        }
        counter+=1
        let newElement = Entry(element: object, previous: lastEntry)
        lastEntry.next = newElement
        tail = newElement
    }
    
    /// Appends the specified element one by one from objects list to the end of this list.
    /// - Parameter objects: objects list
    /// - Complexity: O(*m*) on average, where *m* is the length of
    ///   `objects`, over many calls to `addLast(contentsOf:)` on the same
    ///   LinkedList.
    public mutating func addLast<S: Sequence>(contentOf objects: S) where Element == S.Element {
        objects.forEach { addLast($0) }
    }
    
    
    /// Insert object to position
    /// - Parameters:
    ///   - object: Object to insert
    ///   - index: Position
    public mutating func insert(object: Element, at index: Int) {
        precondition(index < count, "Index out of range")
        if index == 0 {
            addFirst(object)
            return
        }
        
        let entryAtIndex = entry(by: index)
        entryAtIndex?.previous?.next = Entry(element: object,
                                      previous: entryAtIndex?.previous,
                                      next: entryAtIndex)
    }
    
    // MARK: - Remove elements
    
    /// Removes and returns the first element from this list.
    /// - Returns: The first element of the collection if the collection is not
    /// empty; otherwise, `nil`.
    /// - Complexity: O(1)
    public mutating func pollFirst() -> Element? {
        guard !(tail === head) else {
            let element = head?.element
            clearAll()
            return element
        }
        let value = head?.element
        head = head?.next
        counter -= 1
        
        return value
    }
    
    /// Removes and returns the last element from this list.
    /// - Returns: The last element of the collection if the collection is not
    /// empty; otherwise, `nil`
    /// - Complexity: O(1)
    public mutating func pollLast() -> Element? {
        guard !(tail === head) else {
            let element = head?.element
            clearAll()
            return element
        }
        let value = tail?.element
        tail = tail?.previous
        tail?.next = nil
        counter -= 1
        return value
    }
    
    /// Removes all of the elements from this list.
    /// - Complexity: O(1)
    public mutating func clearAll() {
        head = nil
        tail = nil
        counter = 0
    }
    
    // MARK: - Lookup elements
    
    /// Returns the first element in this list.
    /// - Complexity: O(1)
    public var first: Element? {
        return head?.element
    }
    
    /// Returns the last element in this list.
    /// - Complexity: O(1)
    public var last: Element? {
        return tail?.element
    }
    
    subscript (index: Int) -> Element {
        get {
            precondition(index < count, "Index out of range")
            let entryByIndex = entry(by: index)
            return entryByIndex!.element
        }
        set {
            precondition(index < count, "Index out of range")
            let entryByIndex = entry(by: index)
            entryByIndex!.element = newValue
        }
    }
    
    private func entry(by index: Int) -> Entry<Element>? {
        var i = 0
        var next = head
        while next != nil, i != index {
            next = next?.next
            i+=1
        }

        return next
    }
    
    /// Returns the index of the first occurrence of the specified element in this list statring from begin
    /// - Parameter object: object
    /// - Returns: `index` if object exist, otherwise `nil`
    /// - Complexity: O(1)
    public func indexFromBegin(of object: Element) -> Int? where Element: Equatable {
        var next = head
        var iteration = 0
        while next != nil {
            if next?.element == object {
                return iteration
            }
            next = next?.next
            iteration += 1
        }
        
        return nil
    }
    
    /// Returns the index of the first occurrence of the specified element in this list starting from end
    /// - Parameter object: object
    /// - Returns: index` if object exist, otherwise `nil`
    /// - Complexity: O(1)
    public func indexFromEnd(of object: Element) -> Int? where Element: Equatable {
        var next = tail
        var iteration = 0
        while next != nil {
            if next?.element == object {
                return iteration
            }
            next = next?.previous
            iteration += 1
        }
        
        return nil
    }
}

extension LinkedList {
    /// The number of elements in the list.
    /// - Complexity: O(1)
    var count: Int {
        return counter
    }
    
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
    var isEmpty: Bool {
        return head == nil && tail == nil
    }
}

extension LinkedList: Sequence {}

extension LinkedList: IteratorProtocol {
    /// Advance to the next element and return it, or `nil` if no next
    /// element exists.
    mutating public func next() -> Element? {
        return pollFirst()
    }
}

extension LinkedList: CustomStringConvertible {
    /// A textual representation of the linked list and its elements.
    public var description: String {
        var next = head
        var result: [String] = []
        while next != nil {
            result.append("\(next!.element)")
            next = next?.next
        }
        
        return "[" + result.map { "\($0)" }.joined(separator: " ←→ ") + "]"
    }
}

extension LinkedList: ExpressibleByArrayLiteral {
    /// Init with literals
    /// - Parameter elements: element
    public init(arrayLiteral elements: Element...) {
        addLast(contentOf: elements)
    }
    
    public typealias ArrayLiteralElement = Element
}
