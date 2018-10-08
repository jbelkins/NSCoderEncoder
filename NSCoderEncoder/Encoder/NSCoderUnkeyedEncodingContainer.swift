//
//  NSCoderUnkeyedEncodingContainer.swift
//  NSCoderEncoder
//
//  Created by Josh Elkins on 10/7/18.
//

import Foundation


class NSCoderUnkeyedEncodingContainer: UnkeyedEncodingContainer, EncodingDataSource {
    let codingPath: [CodingKey]
    let userInfo: [CodingUserInfoKey: Any]
    var containersToEncode: [EncodingDataSource] = []

    init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey: Any]) {
        self.codingPath = codingPath
        self.userInfo = userInfo
    }

    var count: Int {
        return containersToEncode.count
    }

    func encode<T>(_ value: T) throws where T : Encodable {
        let nextKey = NSCoderCodingKey(intValue: containersToEncode.count)
        let container = NSCoderSingleValueEncodingContainer(codingPath: codingPath + [nextKey], userInfo: userInfo)
        try container.encode(value)
        containersToEncode.append(container)
    }

    func encodeNil() throws {
        let nextKey = NSCoderCodingKey(intValue: containersToEncode.count)
        let container = NSCoderSingleValueEncodingContainer(codingPath: codingPath + [nextKey], userInfo: userInfo)
        try container.encodeNil()
        containersToEncode.append(container)
    }

    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let nextKey = NSCoderCodingKey(intValue: containersToEncode.count)
        let nestedKeyedContainer = NSCoderKeyedEncodingContainer<NestedKey>(codingPath: codingPath + [nextKey], userInfo: userInfo)
        return KeyedEncodingContainer(nestedKeyedContainer)
    }

    func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        let nextKey = NSCoderCodingKey(intValue: containersToEncode.count)
        let nestedUnkeyedContainer = NSCoderUnkeyedEncodingContainer(codingPath: codingPath + [nextKey], userInfo: userInfo)
        return nestedUnkeyedContainer
    }

    func superEncoder() -> Encoder {
        let encoder = NSCoderEncoder(codingPath: codingPath, userInfo: userInfo)
        containersToEncode.append(encoder)
        return encoder
    }

    var encodedData: Data {
        var data = "[".data(using: .utf8)!
        containersToEncode.forEach { container in
            data.append(container.encodedData)
            data.append(",".data(using: .utf8)!)
        }
        if containersToEncode.count > 0 {
            data.removeLast()
        }
        data.append("]".data(using: .utf8)!)
        return data
    }

}
