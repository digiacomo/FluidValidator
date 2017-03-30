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
        
        self.addValidation(withName: "string") { (context) -> (Any?) in
            context.string
        }.addRule(BeNotEmpty())
        
        self.addValidation(withName: "arrExample") { (context) -> (Any?) in
            context.arrExample
        }.addRule(EnumeratorValidator(validatable: ExampleValidator()))
    }
}
