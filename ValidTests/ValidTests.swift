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
            let b: String?
            let c: SubTest
        }
        
        struct SubTest {
            let c: Int
        }
        
        func subTestValidator() -> Validator<SubTest> {
            let validator = Validator<SubTest>()
            validator
                .addValidation(keyPath: \.c)
                .addRule(rule: GreaterThan(max: 1))
            return validator
        }

        func testValidator() -> Validator<Test> {
            let validator = Validator<Test>()
            validator
                .addValidation(keyPath: \.a)
                .addRule(rule: GreaterThan(max: 1))
                .addRule(rule: LowerThan(max: 10))
            
            validator
                .addValidation(keyPath: \.b)
                .addRule(rule: NotEmpty())
            
            validator
                .addValidation(keyPath: \.c)
                .addRule(rule: subTestValidator())
            return validator
        }
        
        let test = Test(a: 1, b: nil, c: SubTest(c: 1))
        let validator = testValidator()
        validator.validate(value: test)
        validator.error(for: \.a)
    }
}
