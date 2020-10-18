//
//  SwiftPlusLinkedListTests.swift
//  Created by Vladyslav Yerofieiev on 14.10.2020.
//  Copyright © 2020 MorayGames. All rights reserved.
//

import Foundation

import XCTest
@testable import SwiftPlus

final class SwiftPlusLinkedListTests: XCTestCase {
    func testCreation() {
        let list: LinkedList = [1, 8, 3, 10, 15]
        XCTAssertEqual(list.count, 5)
        XCTAssertFalse(list.isEmpty)
        XCTAssertNotNil(list)
        XCTAssertEqual(list.description, "[1 ←→ 8 ←→ 3 ←→ 10 ←→ 15]")
    }
    
    func testAddToLast() {
        var list = LinkedList<Int>()
        XCTAssertTrue(list.isEmpty)
        list.addLast(1)
        list.addLast(2)
        list.addLast(3)
        XCTAssertEqual(list.count, 3)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.description, "[1 ←→ 2 ←→ 3]")
    }
    
    func testAddToFirst() {
        var list = LinkedList([])
        XCTAssertTrue(list.isEmpty)
        list.addFirst(1)
        list.addFirst(2)
        list.addFirst(3)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(list.description, "[3 ←→ 2 ←→ 1]")
        
        list.addFirst(contentOf: [4, 5])
        XCTAssertEqual(list.count, 5)
        XCTAssertEqual(list.description, "[5 ←→ 4 ←→ 3 ←→ 2 ←→ 1]")
    }
    
    func testDifferentAdd() {
        var list: LinkedList<Int> = [1, 2, 3]
        XCTAssertEqual(list.description, "[1 ←→ 2 ←→ 3]")
        XCTAssertEqual(list.count, 3)
        list.addFirst(0)
        XCTAssertEqual(list.description, "[0 ←→ 1 ←→ 2 ←→ 3]")
        XCTAssertEqual(list.count, 4)
        list.addLast(4)
        XCTAssertEqual(list.description, "[0 ←→ 1 ←→ 2 ←→ 3 ←→ 4]")
        XCTAssertEqual(list.count, 5)
    }
    
    func testPollFirst() {
        var list: LinkedList<Int> = [1, 2, 3]
        XCTAssertEqual(list.description, "[1 ←→ 2 ←→ 3]")
        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(list.pollFirst(), 1)
        XCTAssertEqual(list.description, "[2 ←→ 3]")
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(list.pollFirst(), 2)
        XCTAssertEqual(list.description, "[3]")
        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.pollFirst(), 3)
        XCTAssertEqual(list.description, "[]")
        XCTAssertEqual(list.count, 0)
        XCTAssertEqual(list.pollFirst(), nil)
        XCTAssertEqual(list.description, "[]")
        XCTAssertEqual(list.count, 0)
    }
    
    func testPollLast() {
        var list: LinkedList<Int> = [1, 2, 3]
        XCTAssertEqual(list.description, "[1 ←→ 2 ←→ 3]")
        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(list.pollLast(), 3)
        XCTAssertEqual(list.description, "[1 ←→ 2]")
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(list.pollLast(), 2)
        XCTAssertEqual(list.description, "[1]")
        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.pollLast(), 1)
        XCTAssertEqual(list.description, "[]")
        XCTAssertEqual(list.count, 0)
        XCTAssertEqual(list.pollLast(), nil)
        XCTAssertEqual(list.description, "[]")
        XCTAssertEqual(list.count, 0)
    }
    
    func testGetValues() {
        var list: LinkedList = [1, 2, 3]
        XCTAssertEqual(list.first, 1)
        XCTAssertEqual(list.last, 3)
        XCTAssertEqual(list.map {"\($0)"}.joined(), "123")
        XCTAssertEqual(list.count, 3)
        
        XCTAssertEqual(list.indexFromBegin(of: 1), 0)
        XCTAssertEqual(list.indexFromBegin(of: 3), 2)
        
        XCTAssertEqual(list.indexFromEnd(of: 1), 2)
        XCTAssertEqual(list.indexFromEnd(of: 3), 0)
        
        XCTAssertEqual(list.indexFromBegin(of: 8), nil)
        XCTAssertEqual(list.indexFromEnd(of: 8), nil)
        
        list.clearAll()
        XCTAssertEqual(list.count, 0)
    }
    
    func testInsertion() {
        var list: LinkedList = [1, 2, 3]
        list.insert(object: 4, at: 0)
        XCTAssertEqual(list.description, "[4 ←→ 1 ←→ 2 ←→ 3]")
        list.insert(object: 5, at: 3)
        XCTAssertEqual(list.description, "[4 ←→ 1 ←→ 2 ←→ 5 ←→ 3]")
        list.insert(object: 6, at: 2)
        XCTAssertEqual(list.description, "[4 ←→ 1 ←→ 6 ←→ 2 ←→ 5 ←→ 3]")
    }
    
    func testSubscript() {
        var list: LinkedList = ["Test", "Get", "Subscript"]
        XCTAssertEqual(list[0], "Test")
        XCTAssertEqual(list[1], "Get")
        XCTAssertEqual(list[2], "Subscript")
        XCTAssertEqual(list.description, "[Test ←→ Get ←→ Subscript]")
        list[1] = "Set"
        
        XCTAssertEqual(list[0], "Test")
        XCTAssertEqual(list[1], "Set")
        XCTAssertEqual(list[2], "Subscript")
        XCTAssertEqual(list.description, "[Test ←→ Set ←→ Subscript]")
    }
    
    static var allTests = [
        ("testCreation", testCreation),
        ("testAddToLast", testAddToLast),
        ("testAddToFirst", testAddToFirst),
        ("testDifferentAdd", testDifferentAdd),
        ("testPollFirst", testPollFirst),
        ("testPollLast", testPollLast),
        ("testGetValues", testGetValues)
    ]
}
