import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftPlusStackTests.allTests),
        testCase(SwiftPlusLinkedListTests.allTests)
    ]
}
#endif
