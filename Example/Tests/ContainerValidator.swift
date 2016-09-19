//
//  ContainerValidator.swift
//  FluidValidator
//
//  Created by FrogRain on 07/02/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import FluidValidator

class ContainerValidator : AbstractValidator<ContainerObject> {
    override init() {
        super.init()
        self.addValidation("test") { (context) -> (AnyObject?) in
            context.test as AnyObject?
        }.addRule(BeNotEmpty())
        
        self.addValidation("example") { (context) -> (AnyObject?) in
            context.example
        }.addRule(ExampleValidator())
    }
}
