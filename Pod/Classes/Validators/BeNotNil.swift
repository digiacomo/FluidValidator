//
//  File.swift
//  TestValidator
//
//  Created by FrogRain on 05/02/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

public class BeNotNil : AbstractValidationRule {
    
    override public func performValidation(object: AnyObject?) -> Bool {
        return object != nil
    }
    
}