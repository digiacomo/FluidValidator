//
//  ValidationRule.swift
//  Valid
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

struct AnyValidationRule<ValueType> {
    private let validate: (ValueType) -> Bool
    private (set) var errorMessage: String
    
    init<Rule: Validatable>(rule: Rule) where Rule.ValueType == ValueType {
        self.validate = rule.validate
        self.errorMessage = rule.errorMessage
    }
    
    func validate(value: ValueType) -> Bool {
        return validate(value)
    }
}
