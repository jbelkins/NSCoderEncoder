//
//  NSCoderKeyedEncodingContainer.swift
//  NSCoderEncoder
//
//  Created by Josh Elkins on 10/7/18.
//

import Foundation


class NSCoderKeyedEncodingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol, EncodingDataSource {
    let codingPath: [CodingKey]
    let userInfo: [CodingUserInfoKey: Any]

    var containersToEncode: [String: EncodingDataSource] = [:]

    init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey: Any]) {
        self.codingPath = codingPath
        self.userInfo = userInfo
    }

    func encodeNil(forKey key: Key) throws {
        let containerforKey = NSCoderSingleValueEncodingContainer(codingPath: codingPath + [key], userInfo: userInfo)
        try containerforKey.encodeNil()
        containersToEncode[key.stringValue] = containerforKey
    }

    func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        let containerforKey = NSCoderSingleValueEncodingContainer(codingPath: codingPath + [key], userInfo: userInfo)
        try containerforKey.encode(value)
        containersToEncode[key.stringValue] = containerforKey
    }

    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        let nestedKeyedContainer = NSCoderKeyedEncodingContainer<NestedKey>(codingPath: codingPath, userInfo: userInfo)
        containersToEncode[key.stringValue] = nestedKeyedContainer
        return KeyedEncodingContainer(nestedKeyedContainer)
    }

    func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        let nestedUnkeyedContainer = NSCoderUnkeyedEncodingContainer(codingPath: codingPath, userInfo: userInfo)
        containersToEncode[key.stringValue] = nestedUnkeyedContainer
        return nestedUnkeyedContainer
    }

    func superEncoder() -> Encoder {
        guard let superKey = Key(stringValue: "super") else { fatalError("\(Key.self) does not have a key for super") }
        return superEncoder(forKey: superKey)
    }

    func superEncoder(forKey key: Key) -> Encoder {
        let encoder = NSCoderEncoder(codingPath: codingPath, userInfo: userInfo)
        containersToEncode[key.stringValue] = encoder
        return encoder
    }

    var encodedData: Data {
        var data = "{".data(using: .utf8)!
        containersToEncode.forEach { (key, container) in
            let keyEncoder = NSCoderSingleValueEncodingContainer(codingPath: codingPath, userInfo: userInfo)
            try! keyEncoder.encode(key)
            data.append(keyEncoder.encodedData)
            data.append(":".data(using: .utf8)!)
            data.append(container.encodedData)
            data.append(",".data(using: .utf8)!)
        }
        if containersToEncode.count > 0 {
            data.removeLast()
        }
        data.append("}".data(using: .utf8)!)
        return data
    }
}
