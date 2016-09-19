//
//  EnumeratorValidator.swift
//  Pods
//
//  Created by FrogRain on 07/02/16.
//
//

import Foundation

open class EnumeratorValidator: AbstractValidator<NSMutableDictionary> {
    fileprivate var validatable:Validatable
    
    public init(validatable:Validatable){
        self.validatable = validatable
        super.init()
    }
    
    open override func performValidation(_ object: AnyObject?) -> Bool {
        guard let object = object else {
            return false
        }
        return self.validate(object)
    }
    
    override open func validate(_ object: AnyObject?) -> Bool {
        guard let arrObjects = object as? Array<AnyObject> else {
            return false
        }
        let dict = NSMutableDictionary()
        for (index, value) in arrObjects.enumerated() {
            dict.setObject(value, forKey: index.description as NSCopying)
            self.addValidation(index.description, targetGetter: { (context) -> (AnyObject?) in
                value
            }).addRule(self.validatable)
        }
        return super.validate(dict)
    }
    
    override open func hydrateFailMessage(_ message: FailMessage, localizedSubject: String, failValue: AnyObject?, context: AnyObject) {
        let error = ErrorMessage()
        error.compact = self.errorMessage(localizedSubject, failValue: failValue, context: context)
        error.extended = self.errorMessageExtended(localizedSubject, failValue: failValue, context: context)
        
        message.errors.append(error)
        
        guard let arrObject = failValue as? Array<AnyObject> else {
            return
        }
        for(index, _) in arrObject.enumerated() {
            let error = self.errorsForValidation(index.description)
            message.setObject(error, forKey: index.description)
        }
    }
}
