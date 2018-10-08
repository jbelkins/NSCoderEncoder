//
//  NSCoderSingleValueEncodingContainer.swift
//  NSCoderEncoder
//
//  Created by Josh Elkins on 10/7/18.
//

import Foundation


class NSCoderSingleValueEncodingContainer: SingleValueEncodingContainer, EncodingDataSource {
    var encodedData = Data()
    let codingPath: [CodingKey]
    let userInfo: [CodingUserInfoKey: Any]

    init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey: Any]) {
        self.codingPath = codingPath
        self.userInfo = userInfo
    }

    func encodeNil() throws {
        guard let dataForNil = "null".data(using: .utf8) else { throw "Cannot encode nil" }
        encodedData.append(dataForNil)
    }

    func encode(_ value: Bool) throws {
        guard let dataForBool = (value ? "true" : "false").data(using: .utf8) else { throw "Cannot encode bool" }
        encodedData.append(dataForBool)
    }

    func encode(_ value: String) throws {
        guard let dataForString = value.data(using: .utf8) else { throw "Cannot encode string" }
        let dataForDoubleQuote = "\"".data(using: .utf8)!
        encodedData.append(dataForDoubleQuote)
        encodedData.append(dataForString)
        encodedData.append(dataForDoubleQuote)
    }

    func encode(_ value: Double) throws {
        guard let dataForDouble = "\(value)".data(using: .utf8) else { throw "Cannot encode double" }
        encodedData.append(dataForDouble)
    }

    func encode(_ value: Float) throws {
        guard let dataForFloat = "\(value)".data(using: .utf8) else { throw "Cannot encode float" }
        encodedData.append(dataForFloat)
    }

    func encode(_ value: Int) throws {
        guard let dataForInt = "\(value)".data(using: .utf8) else { throw "Cannot encode int" }
        encodedData.append(dataForInt)
    }

    func encode(_ value: Int8) throws {
        guard let dataForInt8 = "\(value)".data(using: .utf8) else { throw "Cannot encode int8" }
        encodedData.append(dataForInt8)
    }

    func encode(_ value: Int16) throws {
        guard let dataForInt16 = "\(value)".data(using: .utf8) else { throw "Cannot encode int16" }
        encodedData.append(dataForInt16)
    }

    func encode(_ value: Int32) throws {
        guard let dataForInt32 = "\(value)".data(using: .utf8) else { throw "Cannot encode int32" }
        encodedData.append(dataForInt32)
    }

    func encode(_ value: Int64) throws {
        guard let dataForInt64 = "\(value)".data(using: .utf8) else { throw "Cannot encode int64" }
        encodedData.append(dataForInt64)
    }

    func encode(_ value: UInt) throws {
        guard let dataForUInt = "\(value)".data(using: .utf8) else { throw "Cannot encode uint" }
        encodedData.append(dataForUInt)
    }

    func encode(_ value: UInt8) throws {
        guard let dataForUInt8 = "\(value)".data(using: .utf8) else { throw "Cannot encode uint8" }
        encodedData.append(dataForUInt8)
    }

    func encode(_ value: UInt16) throws {
        guard let dataForUInt16 = "\(value)".data(using: .utf8) else { throw "Cannot encode uint16" }
        encodedData.append(dataForUInt16)
    }

    func encode(_ value: UInt32) throws {
        guard let dataForUInt32 = "\(value)".data(using: .utf8) else { throw "Cannot encode uint32" }
        encodedData.append(dataForUInt32)
    }

    func encode(_ value: UInt64) throws {
        guard let dataForUInt64 = "\(value)".data(using: .utf8) else { throw "Cannot encode uint64" }
        encodedData.append(dataForUInt64)
    }

    func encode<T>(_ value: T) throws where T : Encodable {
        let encoder = NSCoderEncoder(codingPath: codingPath, userInfo: userInfo)
        try value.encode(to: encoder)
        encodedData.append(encoder.encodedData)
    }


}
