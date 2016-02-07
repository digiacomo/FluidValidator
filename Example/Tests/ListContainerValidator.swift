//
//  EnumerableNested.swift
//  FluidValidator
//
//  Created by FrogRain on 07/02/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import FluidValidator

class ListContainerValidator : AbstractValidator<ListContainer> {
    override init() {
        super.init()
        
        self.addValidation("string") { (context) -> (AnyObject?) in
            context.string
        }.addRule(BeNotEmpty())
        
        self.addValidation("arrExample") { (context) -> (AnyObject?) in
            context.arrExample
        }.addRule(EnumeratorValidator(validatable: ExampleValidator()))
    }
}