//
//  AbstractValidator.swift
//  TestValidator
//
//  Created by FrogRain on 31/01/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

public class AbstractValidator<T:AnyObject> : ValidationBase {
    private var validations:Array<Validation<T>> = Array<Validation<T>>()
    
    public override init() {
        super.init()
    }
    
    public func validate(object: AnyObject) -> Bool {
        var result = true
        for validation in self.validations {
            let validationResult = self.validate(validation.validationName, context: object as! T)
            result = result && validationResult
        }
        return result
    }
    
    func validate(name:String!, context: T) -> Bool {
        let validations = self.validations.filter({(validation) -> Bool in
            validation.validationName == name
        })
        var validationResult = true
        for validation in validations {
            let result = validation.runValidation(context)
            validationResult = validationResult && result
        }
        return validationResult
    }
    
    public func addValidation(name:String!, targetGetter:(context:T)->(AnyObject?)) -> Validation<T> {
        let validation = Validation(name: name, targetGetter: targetGetter)
        self.validations.append(validation)
        return validation
    }
    
    public func allErrors() -> FailMessage {
        let error = FailMessage()
        let validationNames = self.validations.map({(validation) -> String in
            validation.validationName
        })
        for name in validationNames {
            let failMessage = self.errorsForValidation(name)
            if(failMessage.errors.count == 0 && failMessage.failingFields().count == 0) {
                continue
            }
            error.setObject(failMessage, forKey: name)
        }
        return error
    }
    
    
    func errorsForValidation(name:String) -> FailMessage {
        let validations = self.validations.filter { (validation) -> Bool in
            validation.validationName == name
        }
        
        let failMessage = validations.first!.allErrors()
        for validation in validations {
            let validationFail = validation.allErrors()
            let joinedArrays = failMessage.errors + validationFail.errors
            failMessage.errors = Array(Set<ErrorMessage>(joinedArrays))
        }
        return failMessage
    }
    
    // override ValidationBase (which implements Validatable)
    override public func performValidation(object:AnyObject?) -> Bool {
        return self.validate(object as! T)
    }
    
    override public func hydrateFailMessage(message: FailMessage!, localizedSubject: String!, failValue: AnyObject?, context: AnyObject) {
        message.summary.compact = self.errorMessage(localizedSubject, failValue: failValue, context: context)
        message.summary.extended = self.errorMessageExtended(localizedSubject, failValue: failValue, context: context)
        
        for validation in self.validations {
            message.setObject(validation.allErrors(), forKey: validation.validationName)
        }
    }
    
    override func errorTextLocalized() -> String {
        var message = super.errorTextLocalized()
        let className:String! = String(self.dynamicType.self)
        var key = String(format: "%@.error.message", className)
        if(message == key) {
            key = "AbstractValidator.error.message"
            message = LocalizationHelper.localizeThis(key)
        }
        return message
    }
    
    override func errorTextExtendedLocalized() -> String {
        var message = super.errorTextExtendedLocalized()
        let className:String! = String(self.dynamicType.self)
        var key = String(format: "%@.error.message.extended", className)
        if(message == key) {
            key = "AbstractValidator.error.message.extended"
            message = LocalizationHelper.localizeThis(key)
        }
        return message
    }
}