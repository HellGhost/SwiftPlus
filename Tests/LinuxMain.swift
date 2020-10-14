import XCTest

import SwiftPlusTests

var tests = [XCTestCaseEntry]()

tests += SwiftPlusStackTests.allTests()
tests += SwiftPlusLinkedListTests.allTests()

XCTMain(tests)
