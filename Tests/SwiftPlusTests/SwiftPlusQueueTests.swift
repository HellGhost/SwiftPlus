//
//  File.swift
//  
//
//  Created by Vladyslav Yerofieiev on 14.10.2020.
//
import XCTest
@testable import SwiftPlus

final class SwiftPlusQueueTests: XCTestCase {
    func testCreation() {
        let queue: SPQueue = [1, 8, 3, 10, 15]
        XCTAssertEqual(queue.count, 5)
        XCTAssertFalse(queue.isEmpty)
        XCTAssertNotNil(queue)
        XCTAssertEqual(queue.top, 15)
        XCTAssertEqual(queue.description, "[15 → 10 → 3 → 8 → 1]")
        
        let set = Set(["a", "b", "c"])
        let queue2 = SPQueue(set)
        XCTAssertEqual(queue2.count, 3)
        XCTAssertTrue(queue2.isExist("a"))
        XCTAssertTrue(queue2.isExist("b"))
        XCTAssertTrue(queue2.isExist("c"))
    }
    
    func testEnqueue() {
        var queue = SPQueue<Int>()
        XCTAssertTrue(queue.isEmpty)
        queue.enqueue(1)
        queue.enqueue(contentsOf: [2, 3])
        queue.enqueue(4)
        queue.enqueue(contentsOf: [5])
        XCTAssertEqual(queue.map {"\($0)"}.joined(), "54321")
        
    }
    
    func testDequeue() {
        var queue: SPQueue = [1, 2, 3, 4, 5]
        XCTAssertEqual(queue.count, 5)
        XCTAssertEqual(queue.description, "[5 → 4 → 3 → 2 → 1]")
        let value = queue.dequeue()
        XCTAssertEqual(value, 5)
        XCTAssertEqual(queue.description, "[4 → 3 → 2 → 1]")
        XCTAssertEqual(queue.count, 4)
        queue.clearAll()
        XCTAssertEqual(queue.count, 0)
    }
    

    static var allTests = [
        ("testCreation", testCreation),
        ("testEnqueue", testEnqueue),
        ("testDequeue", testDequeue),
    ]
}
