//
//  ValidationBase.swift
//  TestValidator
//
//  Created by FrogRain on 04/02/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

open class ValidationBase : Validatable {
    open var overrideErrorMessage:String?
    open var overrideErrorMessageExtended:String?
    
    public init() {}
    
    open func performValidation(onObject object:AnyObject?) -> Bool {
        fatalError("Not implemented error")
    }
    
    open func hydrateError(withFailMessage message: FailMessage, localizedSubject: String, failValue: AnyObject?, context: AnyObject) {
        fatalError("Not implemented error")
    }
    
    func optionalValueDescription(_ value:AnyObject?) -> String {
        var valueString = "";
        if let value = value {
            valueString = value.description
        }else{
            valueString = "nil"
        }
        return valueString
    }
    
    func errorMessage(_ subject:String, failValue: AnyObject?, context: AnyObject) -> String {
        var message = self.errorTextLocalized()
        if let overrideMessage = self.overrideErrorMessage {
            message = overrideMessage
        }
        return String(format: message, subject, self.optionalValueDescription(failValue))
    }
    
    func errorTextLocalized() -> String {
        let className = String(describing: type(of: self).self)
        let key = String(format: "%@.error.message", className)
        return LocalizationHelper.localizeThis(key)
    }
    
    func errorMessageExtended(_ subject:String, failValue: AnyObject?, context: AnyObject) -> String {
        var message = self.errorTextExtendedLocalized()
        if let overrideMessage = self.overrideErrorMessage {
            message = overrideMessage
        }
        return String(format: message, subject, self.optionalValueDescription(failValue))
    }
    
    func errorTextExtendedLocalized() -> String {
        let className = String(describing: type(of: self).self)
        let key = String(format: "%@.error.message.extended", className)
        return LocalizationHelper.localizeThis(key)
    }
}
