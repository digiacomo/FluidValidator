//
//  Validation.swift
//  TestValidator
//
//  Created by FrogRain on 31/01/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

open class Validation<T:AnyObject> {

    var validatables:Array<Validatable> = Array<Validatable>()
    var error:FailMessage = FailMessage()
    var validationName:String

    var whenCondition:((_ context:T) -> (Bool))?
    var targetGetter:(_ context:T)->(Any?)
    
    
    public init(name:String, targetGetter:@escaping (_ context:T)->(Any?)){
        self.validationName = name
        self.validatables = Array<Validatable>()
        self.error = FailMessage()
        self.targetGetter = targetGetter
    }
    
    open func runValidation(_ object:T) -> Bool {
        self.error = FailMessage()
        
        for validatable in self.validatables {
            let target = self.targetGetter(object) as AnyObject?
            
            if let whenCondition = self.whenCondition , !whenCondition(object) {
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
    
    @discardableResult open func addRule(_ validatable:Validatable) -> Self {
        self.validatables.append(validatable)
        return self
    }
    
    @discardableResult open func when(_ condition:@escaping (_ context:T) -> (Bool)) -> Self {
        self.whenCondition = condition
        return self
    }
    
    open func allErrors() -> FailMessage {
        return self.error
    }

    open func localizeValidationName(_ name:String, context:T) -> String {
        let className = String(describing: T.self)
        let key = String(format: "%@.%@.error.name", className, name)
        return LocalizationHelper.localizeThis(key)
    }
}
