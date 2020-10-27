import Foundation

public enum UnionFindError: Error {
  case NotFound(Any)
}

public protocol UnionFind {
  associatedtype Element: Hashable

  /// Add new element to union find
  /// - Parameter element: element must be unique
  func add(_ element: Element)

  /// Union (Connect) elements in union
  /// - Parameters:
  ///   - firstElement: First element
  ///   - secondElement: Second element
  /// - Throws: Error if elements not included in this union
  func union(_ firstElement: Element, and secondElement: Element) throws

  /// Check if elements has connections
  /// - Parameters:
  ///   - firstElement: First element
  ///   - secondElement: Second element
  /// - Throws: Error if elements not included in this union
  /// - Returns: `true` in case if connected `false` in case if not connected
  func isConnected(_ firstElement: Element, and secondElement: Element) throws -> Bool
}

/// Efficient data structure for union-find
public class UnionQuickUnion <Element: Hashable>: UnionFind, CustomStringConvertible {

  private var elements: [Element: Element] = [:]

  /// Create empty union find
  public init() {

  }
  /// Create union find with elements
  /// - Parameter elements: elements must be unique
  /// - Complexity: O(*n*), where *n* is length of the  `elements`
  public init(elements: [Element]) {
    elements.forEach { add($0) }
  }

  public func add(_ element: Element) {
    elements[element] = element
  }

  public func union(_ firstElement: Element, and secondElement: Element) throws {
    let fistRoot = try root(of: firstElement)
    let secondRoot = try root(of: secondElement)
    guard fistRoot != secondRoot else {
      return
    }
    if fistRoot.size < secondRoot.size {
      elements[fistRoot.element] = fistRoot.element
    } else {
      elements[secondRoot.element] = fistRoot.element
    }
  }

  public func isConnected(_ firstElement: Element, and secondElement: Element) throws -> Bool {
    let fistRoot = try root(of: firstElement)
    let secondRoot = try root(of: secondElement)
    return fistRoot.element == secondRoot.element
  }

  /// Get index of element
  /// - Parameter element: element
  /// - Throws: Error if element not included in this union
  /// - Returns: Element index in elements
  /// - Complexity: O(1)
  private func root(of element: Element) throws -> (element: Element, size: Int) {
    guard let contantElement = elements[element] else {
      throw UnionFindError.NotFound(element)
    }
    if contantElement == element {
      return (element, 0)
    }
    let result = try root(of: contantElement)
    return (result.element, result.size + 1)
  }

  public var description: String {
    return elements
      .map { "\($0.key): \($0.value)" }
      .joined(separator: "\n")
  }
}


/// Efficient data structure for union-find
public class UnionQuickFind <Element: Hashable>: UnionFind, CustomStringConvertible {

  private var elements: [Element: Int] = [:]

  /// Create empty union find
  public init() {

  }
  /// Create union find with elements
  /// - Parameter elements: elements must be unique
  /// - Complexity: O(*n*), where *n* is length of the  `elements`
  public init(elements: [Element]) {
    elements.forEach { add($0) }
  }

  public func add(_ element: Element) {
    elements[element] = elements.count
  }

  public func union(_ firstElement: Element, and secondElement: Element) throws {
    let firstID = try index(of: firstElement)
    let secontID = try index(of: secondElement)
    elements.forEach {
      if $0.value == firstID {
        // Change all elements with first id to second id
        elements[$0.key] = secontID
      }
    }
  }

  public func isConnected(_ firstElement: Element, and secondElement: Element) throws -> Bool {
    let firstID = try index(of: firstElement)
    let secontID = try index(of: secondElement)
    return firstID == secontID
  }

  /// Get index of element
  /// - Parameter element: element
  /// - Throws: Error if element not included in this union
  /// - Returns: Element index in elements
  /// - Complexity: O(1)
  private func index(of element: Element) throws -> Int {
    guard let elementID = elements[element] else {
      throw UnionFindError.NotFound(element)
    }
    return elementID
  }

  public var description: String {
    return elements
      .sorted{ $0.value < $1.value }
      .map { "\($0.key): \($0.value)" }
      .joined(separator: "\n")
  }
}
