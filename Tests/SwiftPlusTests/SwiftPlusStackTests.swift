//
//  SwiftPlusStackTests.swift
//  Created by Vladyslav Yerofieiev on 14.10.2020.
//
import XCTest
@testable import SwiftPlus

final class SwiftPlusStackTests: XCTestCase {
    func testCreation() {
        let stack: Stack = [1, 8, 3, 10, 15]
        XCTAssertEqual(stack.count, 5)
        XCTAssertFalse(stack.isEmpty)
        XCTAssertNotNil(stack)
        XCTAssertEqual(stack.top, 15)
        XCTAssertEqual(stack.description, "[15 → 10 → 3 → 8 → 1]")
        
        let set = Set(["a", "b", "c"])
        let queue2 = Stack(set)
        XCTAssertEqual(queue2.count, 3)
        XCTAssertTrue(queue2.isExist("a"))
        XCTAssertTrue(queue2.isExist("b"))
        XCTAssertTrue(queue2.isExist("c"))
    }
    
    func testPush() {
        var stack = Stack<Int>()
        XCTAssertTrue(stack.isEmpty)
        stack.push(1)
        stack.push(contentsOf: [2, 3])
        stack.push(4)
        stack.push(contentsOf: [5])
        XCTAssertEqual(stack.map {"\($0)"}.joined(), "54321")
        
    }
    
    func testPop() {
        var stack: Stack = [1, 2, 3, 4, 5]
        XCTAssertEqual(stack.count, 5)
        XCTAssertEqual(stack.description, "[5 → 4 → 3 → 2 → 1]")
        let value = stack.pop()
        XCTAssertEqual(value, 5)
        XCTAssertEqual(stack.description, "[4 → 3 → 2 → 1]")
        XCTAssertEqual(stack.count, 4)
        stack.clearAll()
        XCTAssertEqual(stack.count, 0)
    }
    

    static var allTests = [
        ("testCreation", testCreation),
        ("testPush", testPush),
        ("testPop", testPop),
    ]
}
