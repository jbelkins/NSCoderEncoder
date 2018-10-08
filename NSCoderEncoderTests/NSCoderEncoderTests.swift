//
//  NSCoderEncoderTests.swift
//  NSCoderEncoderTests
//
//  Created by Josh Elkins on 10/7/18.
//

import XCTest
@testable import NSCoderEncoder


class NSCoderEncoderTests: XCTestCase {
    var originalObject: TestClass!

    struct TestStruct: Codable, Equatable {
        let id: Int
        let name: String
        let components: [String]
    }

    class TestSuperClass: Codable {
        let id: Int
        let testStruct: TestStruct

        init(id: Int, testStruct: TestStruct) {
            self.id = id
            self.testStruct = testStruct
        }
    }

    class TestClass: TestSuperClass, Equatable {
        let pairs: [String: String]

        static func == (lhs: NSCoderEncoderTests.TestClass, rhs: NSCoderEncoderTests.TestClass) -> Bool {
            return lhs.id == rhs.id && lhs.testStruct == rhs.testStruct && lhs.pairs == rhs.pairs
        }

        init(id: Int, testStruct: TestStruct, pairs: [String: String]) {
            self.pairs = pairs
            super.init(id: id, testStruct: testStruct)
        }

        override func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: TestClassCodingKeys.self)
            try super.encode(to: container.superEncoder())
            try container.encode(pairs, forKey: .pairs)
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: TestClassCodingKeys.self)
            pairs = try container.decode([String: String].self, forKey: .pairs)
            try super.init(from: container.superDecoder())
        }

        enum TestClassCodingKeys: CodingKey {
            case `super`
            case pairs
        }
    }

    override func setUp() {
        let originalTestStruct = TestStruct(id: 123, name: "The Original Test Struct", components: ["onesy", "twosy", "threesy"])
        let originalPairs = ["guard1": "Michael Jordan", "guard2": "Steve Kerr", "forward1": "Scottie Pippen", "forward2": "Dennis Rodman", "center": "Bill Cartwright"]
        originalObject = TestClass(id: 456, testStruct: originalTestStruct, pairs: originalPairs)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONDecoderCanDecodeDataEncodedByNSCoderEncoder() {
        let encoder = NSCoderEncoder()
        try! originalObject.encode(to: encoder)
        let data = encoder.encodedData
        print(String(data: data, encoding: .utf8)!)
        let decoder = JSONDecoder()
        let finalObject = try? decoder.decode(TestClass.self, from: data)
        XCTAssertEqual(originalObject, finalObject)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
