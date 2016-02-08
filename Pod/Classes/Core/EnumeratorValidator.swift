//
//  EnumeratorValidator.swift
//  Pods
//
//  Created by FrogRain on 07/02/16.
//
//

import Foundation

public class EnumeratorValidator: AbstractValidator<NSMutableDictionary> {
    private var validatable:Validatable
    
    public init(validatable:Validatable){
        self.validatable = validatable
        super.init()
    }
    
    public override func performValidation(object: AnyObject?) -> Bool {
        return self.validate(object!)
    }
    
    override public func validate(object: AnyObject) -> Bool {
        let arrObjects = object as! Array<AnyObject>
        let dict = NSMutableDictionary()
        for (index, value) in arrObjects.enumerate() {
            dict.setObject(value, forKey: index.description)
            self.addValidation(index.description, targetGetter: { (context) -> (AnyObject?) in
                value
            }).addRule(self.validatable)
        }
        return super.validate(dict)
    }
    
    override public func hydrateFailMessage(message: FailMessage!, localizedSubject: String!, failValue: AnyObject?, context: AnyObject) {
        let error = ErrorMessage()
        error.compact = self.errorMessage(localizedSubject, failValue: failValue?.description, context: context)
        error.extended = self.errorMessageExtended(localizedSubject, failValue: failValue?.description, context: context)
        
        message.errors.append(error)
        
        let arrObject = failValue as! Array<AnyObject>
        for(index, _) in arrObject.enumerate() {
            let error = self.errorsForValidation(index.description)
            message.setObject(error, forKey: index.description)
        }
    }
}