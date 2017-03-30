//
//  RegistrationValidator.swift
//  FluidValidator
//
//  Created by Antonio Di Giacomo on 26/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import FluidValidator

class RegistrationValidator:AbstractValidator<UserRegistration> {
    internal override init() {
        super.init()

        self.addValidation(withName: "firstname") { (context) -> (AnyObject?) in
            context.firstname as AnyObject?
        }.addRule(BeNotEmpty())
        
        self.addValidation(withName: "lastname") { (context) -> (AnyObject?) in
            context.lastname as AnyObject?
        }.addRule(BeNotEmpty())
        
        self.addValidation(withName: "email") { (context) -> (AnyObject?) in
            context.email as AnyObject?
        }.addRule(ValidEmail())
    }
}
