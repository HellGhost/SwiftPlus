//
//  SwiftPlusStackTests.swift
//  Created by Vladyslav Yerofieiev on 14.10.2020.
//
import XCTest
@testable import SwiftPlus

final class SwiftPlusQueueTests: XCTestCase {
    func testCreation() {
        let queue: Queue = [1, 8, 3, 10, 15]
        XCTAssertEqual(queue.count, 5)
        XCTAssertFalse(queue.isEmpty)
        XCTAssertNotNil(queue)
        XCTAssertEqual(queue.top, 15)
        XCTAssertEqual(queue.description, "[1 ← 8 ← 3 ← 10 ← 15]")
        
        let set = Set(["a", "b", "c"])
        let queue2 = Queue(set)
        XCTAssertEqual(queue2.count, 3)
        XCTAssertTrue(queue2.isExist("a"))
        XCTAssertTrue(queue2.isExist("b"))
        XCTAssertTrue(queue2.isExist("c"))
    }
    
    func testEnqueue() {
        var queue = Queue<Int>()
        XCTAssertTrue(queue.isEmpty)
        queue.enqueue(1)
        queue.enqueue(contentsOf: [2, 3])
        queue.enqueue(4)
        queue.enqueue(contentsOf: [5])
        XCTAssertEqual(queue.map {"\($0)"}.joined(), "12345")
        
    }
    
    func testDequeue() {
        var queue: Queue = [1, 2, 3, 4, 5]
        XCTAssertEqual(queue.count, 5)
        XCTAssertEqual(queue.description, "[1 ← 2 ← 3 ← 4 ← 5]")
        let value = queue.dequeue()
        XCTAssertEqual(value, 1)
        XCTAssertEqual(queue.description, "[2 ← 3 ← 4 ← 5]")
        XCTAssertEqual(queue.count, 4)
        queue.clearAll()
        XCTAssertEqual(queue.count, 0)
    }
    

    static var allTests = [
        ("testCreation", testCreation),
        ("testPush", testEnqueue),
        ("testPop", testDequeue),
    ]
}
