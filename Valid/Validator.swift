//
//  Validator.swift
//  Valid
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

enum ValidationResult {
    case valid, invalid([String])
}

open class Validator<T>: Validatable {
    let errorMessage: String = "Validation failed"
    
    private var validations: [AnyValidation<T>] = []
    private (set) var errors: [PartialKeyPath<T>: ValidationResult] = [:]
    
    @discardableResult
    func validate(value: T) -> Bool {
        return validations.reduce(true) { result, validation -> Bool in
            let validationResult = validation.validate(value)
            let keyPath = validation.keyPath
            if !validationResult {
                errors[keyPath] = .invalid(validation.getErrors())
            } else {
                errors[keyPath] = .valid
            }
            return result && validationResult
        }
    }
    
    func addValidation<PropertyType>(keyPath: KeyPath<T, PropertyType>) -> Validation<T, PropertyType> {
        let validation = Validation(keyPath: keyPath)
        let anyValidation = AnyValidation(validation: validation)
        validations.append(anyValidation)
        return validation
    }
    
    func isError<P>(for keyPath: KeyPath<T, P>) -> Bool {
        switch errors[keyPath] {
        case .invalid:
            return true
        case .none,.valid:
            return false
        }
    }
    
    func firstError<P>(for keyPath: KeyPath<T, P>) -> String? {
        guard let result = errors[keyPath],
            case .invalid(let messages) = result else {
            return nil
        }
        return messages.first
    }
}
