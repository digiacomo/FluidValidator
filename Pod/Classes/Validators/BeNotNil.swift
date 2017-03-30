//
//  File.swift
//  TestValidator
//
//  Created by FrogRain on 05/02/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

open class BeNotNil : AbstractValidationRule {
    
    override open func performValidation(onObject object: AnyObject?) -> Bool {
        return object != nil
    }
    
}
