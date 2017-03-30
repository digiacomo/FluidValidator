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
        self.addValidation(withName: "test") { (context) -> (Any?) in
            context.test
        }.addRule(BeNotEmpty())
        
        self.addValidation(withName: "example") { (context) -> (Any?) in
            context.example
        }.addRule(ExampleValidator())
    }
}
