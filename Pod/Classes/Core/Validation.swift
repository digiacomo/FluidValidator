//
//  Validation.swift
//  TestValidator
//
//  Created by FrogRain on 31/01/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

public class Validation<T:AnyObject> {

    var validatables:Array<Validatable> = Array<Validatable>()
    var error:FailMessage = FailMessage()
    var validationName:String!

    var whenCondition:((context:T) -> (Bool))?
    var targetGetter:(context:T)->(AnyObject?)
    
    
    public init(name:String!, targetGetter:(context:T)->(AnyObject?)){
        self.validationName = name
        self.validatables = Array<Validatable>()
        self.error = FailMessage()
        self.targetGetter = targetGetter
    }
    
    public func runValidation(object:T) -> Bool {
        self.error = FailMessage()
        for validatable in self.validatables {
            let target = self.targetGetter(context: object)
            
            if(self.whenCondition != nil && !self.whenCondition!(context: object)){
                return true
            }
            
            if(!validatable.performValidation(target)) {
                let localizedName = self.localizeValidationName(self.validationName, context:object)
                
                validatable.hydrateFailMessage(self.error, localizedSubject: localizedName, failValue: target, context: object)
                return false
            }
        }
        return true
    }
    
    public func addRule(validatable:Validatable) -> Self {
        self.validatables.append(validatable)
        return self
    }
    
    public func when(condition:(context:T) -> (Bool)) -> Self {
        self.whenCondition = condition
        return self
    }
    
    public func allErrors() -> FailMessage {
        return self.error
    }

    public func localizeValidationName(name:String!, context:T) -> String! {
        let className:String! = String(T.self)
        let key = String(format: "%@.%@.error.name", className, name)
        return LocalizationHelper.localizeThis(key)
    }
}