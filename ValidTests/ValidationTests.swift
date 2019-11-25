//
//  ValidationTests.swift
//  ValidTests
//
//  Created by Antonio Di Giacomo on 25/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import XCTest
@testable import Valid

class ValidationTests: XCTestCase {
    func testValidation() {
        
        let validation = Validation<Test, String>(keyPath: \.title)
        let rule = StringInRange(minLength: 0, maxLength: 10)
        validation.addRule(rule: rule)
        
        let test = Test(number: 0, title: "")
        validation.validate(value: test)
        XCTAssertEqual(validation.getErrors().first, rule.errorMessage)
    }
}

extension ValidationTests {
    struct Test {
        let number: Int
        let title: String
    }
}
