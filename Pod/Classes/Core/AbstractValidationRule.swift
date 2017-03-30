//
//  ValidationRule.swift
//  TestValidator
//
//  Created by FrogRain on 31/01/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

open class AbstractValidationRule: ValidationBase {
    
    override open func performValidation(onObject object: AnyObject?) -> Bool {
        fatalError("Not implemented error")
    }
    
    override open func hydrateError(withFailMessage message: FailMessage, localizedSubject: String, failValue: AnyObject?, context: AnyObject) {
        let error = ErrorMessage()
        error.compact = self.errorMessage(localizedSubject, failValue: failValue, context: context)
        error.extended = self.errorMessageExtended(localizedSubject, failValue: failValue, context: context)
        message.errors.append(error)
    }
}
