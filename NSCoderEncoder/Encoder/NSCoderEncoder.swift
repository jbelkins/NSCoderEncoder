//
//  NSCoderEncoder.swift
//  NSCoderEncoder
//
//  Created by Josh Elkins on 10/7/18.
//

import Foundation


class NSCoderEncoder: Encoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey : Any] = [:]

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        <#code#>
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        <#code#>
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        <#code#>
    }
}
