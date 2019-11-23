//
//  ValidTests.swift
//  ValidTests
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import XCTest
@testable import Valid

class ValidTests: XCTestCase {
    func testExample() {
        struct Test {
            let a: Int
        }


        let test = Test(a: 1)

        let rule1 = GreaterThan(max: 0)
        let anyValidationRule1 = AnyValidationRule(rule: rule1)
        let validation = Validation(keyPath: \Test.a, rules: [
            anyValidationRule1
        ])
        let anyValidation = AnyValidation(validation: validation)
        var validator = Validator<Test>()
        validator
            .addValidation(keyPath: \.a)
            .addRule(rule: GreaterThan())
        
        
        validator.performValidation(on: test)
    }
}
