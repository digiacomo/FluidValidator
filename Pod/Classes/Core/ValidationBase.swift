//
//  ValidationBase.swift
//  TestValidator
//
//  Created by FrogRain on 04/02/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

public class ValidationBase : Validatable {
    public var overrideErrorMessage:String?
    public var overrideErrorMessageExtended:String?
    
    public init() {}
    
    public func performValidation(object:AnyObject?) -> Bool {
        fatalError("Not implemented error")
    }
    
    public func hydrateFailMessage(message: FailMessage, localizedSubject: String, failValue: AnyObject?, context: AnyObject) {
        fatalError("Not implemented error")
    }
    
    func optionalValueDescription(value:AnyObject?) -> String {
        var valueString = "";
        if let value = value {
            valueString = value.description
        }else{
            valueString = "nil"
        }
        return valueString
    }
    
    func errorMessage(subject:String, failValue: AnyObject?, context: AnyObject) -> String {
        var message = self.errorTextLocalized()
        if let overrideMessage = self.overrideErrorMessage {
            message = overrideMessage
        }
        return String(format: message, subject, self.optionalValueDescription(failValue))
    }
    
    func errorTextLocalized() -> String {
        let className = String(self.dynamicType.self)
        let key = String(format: "%@.error.message", className)
        return LocalizationHelper.localizeThis(key)
    }
    
    func errorMessageExtended(subject:String, failValue: AnyObject?, context: AnyObject) -> String {
        var message = self.errorTextExtendedLocalized()
        if let overrideMessage = self.overrideErrorMessage {
            message = overrideMessage
        }
        return String(format: message, subject, self.optionalValueDescription(failValue))
    }
    
    func errorTextExtendedLocalized() -> String {
        let className = String(self.dynamicType.self)
        let key = String(format: "%@.error.message.extended", className)
        return LocalizationHelper.localizeThis(key)
    }
}