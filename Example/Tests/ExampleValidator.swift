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
        
        self.addValidation(withName: "testProperty") { (context) -> (Any?) in
            context.testProperty
        }.addRule(BeNotNil())
        
        self.addValidation(withName: "altProperty") { (context) -> (Any?) in
            context.altProperty
        }.addRule(BeNotEmpty())
        
        self.addValidation(withName: "isTrue") { (context) -> (Any?) in
            context.isTrue
        }.addRule(BeTrue())
        
        self.addValidation(withName: "number") { (context) -> (Any?) in
            context.number
        }.addRule(LessThan(limit: 3, includeLimit: false))
    }
}
