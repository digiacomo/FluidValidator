//
//  ValidationRule.swift
//  Valid
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

struct AnyValidationRule<ValueType>: Validatable {
    private let validate: (ValueType) -> Bool
    
    init<Rule: Validatable>(rule: Rule) where Rule.ValueType == ValueType {
        self.validate = rule.validate
    }
    
    func validate(value: ValueType) -> Bool {
        return validate(value)
    }
}
