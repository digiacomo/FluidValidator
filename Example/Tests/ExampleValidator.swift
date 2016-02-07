//
//  ExampleValidator.swift
//  FluidValidator
//
//  Created by FrogRain on 06/02/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import FluidValidator

class ExampleValidator : AbstractValidator<Example> {
    override init() {
        super.init()
        
        self.addValidation("testProperty") { (context) -> (AnyObject?) in
            context.testProperty
        }.addRule(BeNotNil())
        
        self.addValidation("altProperty") { (context) -> (AnyObject?) in
            context.altProperty
        }.addRule(BeNotEmpty())
        
        self.addValidation("isTrue") { (context) -> (AnyObject?) in
            context.isTrue
        }.addRule(BeTrue())
        
        self.addValidation("number") { (context) -> (AnyObject?) in
            context.number
        }.addRule(LessThan(limit: 3, false))
    }
}