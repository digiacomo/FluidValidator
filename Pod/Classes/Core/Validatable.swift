//
//  Validatable.swift
//  TestValidator
//
//  Created by FrogRain on 31/01/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

public protocol Validatable {
    var overrideErrorMessage:String? {get set}
    var overrideErrorMessageExtended:String? {get set}
    
    func performValidation(_ object:AnyObject?) -> Bool
    
    func hydrateFailMessage(_ message:FailMessage, localizedSubject:String, failValue:AnyObject?, context:AnyObject) -> ()
}
