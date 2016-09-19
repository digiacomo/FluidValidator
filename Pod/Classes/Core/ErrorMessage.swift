//
//  ErrorMessage.swift
//  Pods
//
//  Created by FrogRain on 07/02/16.
//
//

import Foundation

public func ==(lhs: ErrorMessage, rhs: ErrorMessage) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

func ==(lhs: Array<ErrorMessage>, rhs: Array<ErrorMessage>) -> Bool {
    return lhs.hash == lhs.hash
}

extension Array where Element:ErrorMessage {
    var hash: Int {
        get {
            var hash = 0
            forEach { (x: Array.Iterator.Element) -> () in
                hash = hash ^ x.hashValue
            }
            return hash
        }
    }
}

open class ErrorMessage:Hashable {
    open var compact:String
    open var extended:String
    
    init() {
        self.compact = ""
        self.extended = ""
    }
    
    open var hashValue: Int {
        get {
            return self.compact.hash ^ self.extended.hash
        }
    }
}
