//
//  ExampleValidator2.swift
//  FluidValidator
//
//  Created by Antonio Di Giacomo on 28/06/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import FluidValidator

class ExampleValidator2: AbstractValidator<Example> {
    override init() {
        super.init()
        
        let rule1 = InRange(min: 2, max: 8, mode: ComparisonMode.MinMaxExluded)
        
        let rule2 = InRange(min: 4, max: 6, mode: ComparisonMode.MinMaxExluded)
        
        let rule3 = InRange(min: 0, max: 10, mode: ComparisonMode.MinMaxExluded)
        
        self.addValidation("number") { (context) -> (AnyObject?) in
            context.number
        }
            .addRule(rule1)
            .addRule(rule2)
            .addRule(rule3)
    }
}