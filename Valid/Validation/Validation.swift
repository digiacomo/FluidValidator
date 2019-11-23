//
//  Validation.swift
//  Valid
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

//struct Validation2<T, P>: Validatable {
//    typealias ValueType = T
//    let name: String
//    let getter: (T) -> P
//    private (set) var rules: [AnyValidationRule<P>]
//    
//    func validate(value: T) -> Bool {
//        let value = getter(value)
//        return rules.reduce(true) { result, rule -> Bool in
//            guard result else {
//                return false
//            }
//            return result && rule.validate(value: value)
//        }
//    }
//}

class Validation<T, P>: Validatable {
    typealias ValueType = T
    
    let keyPath: KeyPath<T, P>
    private (set) var rules: [AnyValidationRule<P>] = []
    
    func validate(value: T) -> Bool {
        let value = value[keyPath: keyPath]
        return rules.reduce(true) { result, rule -> Bool in
            guard result else {
                return false
            }
            return result && rule.validate(value: value)
        }
    }
    
    @discardableResult
    func addRule<ValidatableType: Validatable>(rule: ValidatableType) -> Validation<T, P> where P == ValidatableType.ValueType {
        rules.append(AnyValidationRule(rule: rule))
        return self
    }
    
    init(keyPath: KeyPath<T, P>) {
        self.keyPath = keyPath
    }
}