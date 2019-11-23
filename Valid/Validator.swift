//
//  Validator.swift
//  Valid
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

open class Validator<T>: Validatable {
    private var validations: [AnyValidation<T>] = []
    
    func validate(value: T) -> Bool {
        return validations.reduce(true) { result, validation -> Bool in
            guard result else {
                return false
            }
            return result && validation.validate(value)
        }
    }
    
    func addValidation<PropertyType>(keyPath: KeyPath<T, PropertyType>) -> Validation<T, PropertyType> {
        let validation = Validation(keyPath: keyPath)
        let anyValidation = AnyValidation(validation: validation)
        validations.append(anyValidation)
        return validation
    }
    
    func error<P>(for keyPath: KeyPath<T, P>) -> Bool {
        return true
    }
}
