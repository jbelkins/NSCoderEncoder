//
//  NSCoderCodingKey.swift
//  NSCoderEncoder
//
//  Created by Josh Elkins on 10/7/18.
//

import Foundation


struct NSCoderCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    init(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
}
