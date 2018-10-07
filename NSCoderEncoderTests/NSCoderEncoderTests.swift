//
//  NSCoderEncoderTests.swift
//  NSCoderEncoderTests
//
//  Created by Josh Elkins on 10/7/18.
//

import XCTest
@testable import NSCoderEncoder


class NSCoderEncoderTests: XCTestCase {

    struct TestStruct: Codable, Equatable {
        let id: Int
        let name: String
        let components: [String]
    }

    class TestSuperClass: Codable, Equatable {
        let id: Int
        let testStruct: TestStruct

        init(id: Int, testStruct: TestStruct) {
            self.id = id
            self.testStruct = testStruct
        }
    }

    class TestClass: TestSuperClass {
        let pairs: [String: String]

        init(id: Int, testStruct: TestStruct, pairs: [String: String]) {
            self.pairs = pairs
            super.init(id: id, testStruct: testStruct)
        }
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONDecoderCanDecodeDataEncodedByNSCoderEncoder() {
        let encoder = NSCoderEncoder.NSCoderEncoder()
        let data =
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
