//
//  Validation.swift
//  Valid
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

class Validation<T, P> {
    let keyPath: KeyPath<T, P>
    private (set) var rules: [AnyValidationRule<P>] = []
    private var errors: [String] = []
    
    @discardableResult
    func validate(value: T) -> Bool {
        let value = value[keyPath: keyPath]
        return rules.reduce(true) { result, rule -> Bool in
            let ruleResult = rule.validate(value: value)
            if !ruleResult {
                errors.append(rule.errorMessage)
            }
            return result && ruleResult
        }
    }
    
    @discardableResult
    func addRule<ValidatableType: Validatable>(rule: ValidatableType) -> Validation<T, P> where P == ValidatableType.ValueType {
        rules.append(AnyValidationRule(rule: rule))
        return self
    }
    
    func getErrors() -> [String] {
        return errors
    }
    
    init(keyPath: KeyPath<T, P>) {
        self.keyPath = keyPath
    }
}

class AnyValidation<ValueType> {
    let validate: (ValueType) -> Bool
    let getErrors: () -> [String]
    
    let keyPath: PartialKeyPath<ValueType>
    
    init<P>(validation: Validation<ValueType, P>){
        self.keyPath = validation.keyPath
        self.validate = validation.validate(value:)
        self.getErrors = validation.getErrors
    }
}
