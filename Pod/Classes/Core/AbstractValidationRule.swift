//
//  ValidationRule.swift
//  TestValidator
//
//  Created by FrogRain on 31/01/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

public class AbstractValidationRule: ValidationBase {
    
    override public func performValidation(object: AnyObject?) -> Bool {
        fatalError("Not implemented error")
    }
    
    override public func hydrateFailMessage(message: FailMessage!, localizedSubject: String!, failValue: AnyObject?, context: AnyObject) {
//        message.summary.compact = self.errorMessage(localizedSubject, failValue: failValue, context: context) //il campo è in errore
//        message.summary.extended = self.errorMessage(localizedSubject, failValue: failValue, context: context) //il campo è in errore: una regola di validazione
        let error = ErrorMessage()
        error.compact = self.errorMessage(localizedSubject, failValue: failValue, context: context)
        error.extended = self.errorMessageExtended(localizedSubject, failValue: failValue, context: context)
        message.errors.append(error)
    }
}