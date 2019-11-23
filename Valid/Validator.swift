//
//  Validator.swift
//  Valid
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

protocol ValidatorProtocol {
    associatedtype TargetType
    var validations: [AnyValidation<TargetType>] { get set }
    mutating func addValidation<PropertyType>(keyPath: KeyPath<TargetType, PropertyType>) -> Validation<TargetType, PropertyType>
}

extension ValidatorProtocol {
    mutating func addValidation<PropertyType>(keyPath: KeyPath<TargetType, PropertyType>) -> Validation<TargetType, PropertyType> {
        var validation = Validation(keyPath: keyPath)
        var anyValidation = AnyValidation(validation: validation)
        validations.append(anyValidation)
        return validation
    }
}

struct Validator<T>: ValidatorProtocol {
    typealias TargetType = T
    internal var validations: [AnyValidation<T>] = []
    
    func performValidation(on target: T) -> Bool {
        return validations.reduce(true) { result, validation -> Bool in
            guard result else {
                return false
            }
            return result && validation.validate(target)
        }
    }
    
    init() {
        
    }
}
