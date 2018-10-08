//
//  NSCoderEncoder.swift
//  NSCoderEncoder
//
//  Created by Josh Elkins on 10/7/18.
//

import Foundation


protocol EncodingDataSource {
    var encodedData: Data { get }
}


class NSCoderEncoder: Encoder, EncodingDataSource {
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey : Any]
    private var container: EncodingDataSource? {
        willSet {
            if container != nil {
                fatalError("Container was already made with this encoder")
            }
        }
    }

    init(codingPath: [CodingKey] = [], userInfo: [CodingUserInfoKey: Any] = [:]) {
        self.codingPath = codingPath
        self.userInfo = userInfo
    }

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        let keyedContainer = NSCoderKeyedEncodingContainer<Key>(codingPath: codingPath, userInfo: userInfo)
        self.container = keyedContainer
        return KeyedEncodingContainer(keyedContainer)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        let unkeyedContainer = NSCoderUnkeyedEncodingContainer(codingPath: codingPath, userInfo: userInfo)
        self.container = unkeyedContainer
        return unkeyedContainer
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        let singleValueContainer = NSCoderSingleValueEncodingContainer(codingPath: codingPath, userInfo: userInfo)
        container = singleValueContainer
        return singleValueContainer
    }

    var encodedData: Data {
        return container?.encodedData ?? Data()
    }
}
