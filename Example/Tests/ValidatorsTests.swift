//
//  ValidatorsTests.swift
//  FluidValidator
//
//  Created by FrogRain on 06/02/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import FluidValidator

class ValidatorsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBeNotNil() {
        let validation = Validation(name: "testValidation") { (context:Example) -> (AnyObject?) in
            return context.testProperty
        }
        let rule = BeNotNil()
        validation.addRule(rule)
        
        let example = Example()
        
        var result = validation.runValidation(example)
        
        var failMessage = validation.allErrors()
        
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.errors.count > 0)
        
        example.testProperty = "test value"
        result = validation.runValidation(example)
        failMessage = validation.allErrors()
        
        XCTAssertTrue(result)
        XCTAssertTrue(failMessage.errors.count == 0)
    }
    
    func testBeNotEmpty() {
        let validation = Validation(name: "testValidation") { (context:Example) -> (AnyObject?) in
            return context.testProperty
        }
        let rule = BeNotEmpty()
        validation.addRule(rule)
        
        let example = Example()
        
        example.testProperty = ""
        var result = validation.runValidation(example)
        var failMessage = validation.allErrors()
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.errors.count > 0)
        
        example.testProperty = "test value"
        result = validation.runValidation(example)
        failMessage = validation.allErrors()
        
        XCTAssertTrue(result)
        XCTAssertTrue(failMessage.errors.count == 0)
    }
    
    func testBeTrue() {
        let validation = Validation(name: "testValidation") { (context:Example) -> (AnyObject?) in
            return context.isTrue
        }
        let rule = BeTrue()
        validation.addRule(rule)
        
        let example = Example()
        
        example.isTrue = false
        var result = validation.runValidation(example)
        var failMessage = validation.allErrors()
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.errors.count > 0)
        
        example.isTrue = true
        result = validation.runValidation(example)
        failMessage = validation.allErrors()
        
        XCTAssertTrue(result)
        XCTAssertTrue(failMessage.errors.count == 0)
    }
    
    func testGreaterThan() {
        let validation = Validation(name: "testValidation") { (context:Example) -> (AnyObject?) in
            return context.number
        }
        let rule = GreaterThan(limit: 4, includeLimit: true)
        validation.addRule(rule)
        
        let example = Example()
        
        example.number = 0
        var result = validation.runValidation(example)
        var failMessage = validation.allErrors()
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.errors.count > 0)
        
        example.number = 4
        result = validation.runValidation(example)
        failMessage = validation.allErrors()
        XCTAssertTrue(result)
        XCTAssertTrue(failMessage.errors.count == 0)
        
        example.number = 5
        result = validation.runValidation(example)
        failMessage = validation.allErrors()
        XCTAssertTrue(result)
        XCTAssertTrue(failMessage.errors.count == 0)
    }
    
    func testLessThan() {
        let validation = Validation(name: "testValidation") { (context:Example) -> (AnyObject?) in
            return context.number
        }
        let rule = LessThan(limit: 4, true)
        validation.addRule(rule)
        
        let example = Example()
        
        example.number = 5
        var result = validation.runValidation(example)
        var failMessage = validation.allErrors()
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.errors.count > 0)
        
        example.number = 4
        result = validation.runValidation(example)
        failMessage = validation.allErrors()
        XCTAssertTrue(result)
        XCTAssertTrue(failMessage.errors.count == 0)
        
        example.number = 3
        result = validation.runValidation(example)
        failMessage = validation.allErrors()
        XCTAssertTrue(result)
        XCTAssertTrue(failMessage.errors.count == 0)
    }
    
    func testInRange() {
        let validation = Validation(name: "testValidation") { (context:Example) -> (AnyObject?) in
            return context.number
        }
        let rule = InRange(min: 1, max: 5, mode: .MinMaxExluded)
        validation.addRule(rule)
        
        let example = Example()
        example.number = 6
        var result = validation.runValidation(example)
        var failMessage = validation.allErrors()
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.errors.count > 0)
        
        example.number = 4
        result = validation.runValidation(example)
        failMessage = validation.allErrors()
        XCTAssertTrue(result)
        XCTAssertTrue(failMessage.errors.count == 0)
        
        example.number = 3
        result = validation.runValidation(example)
        failMessage = validation.allErrors()
        XCTAssertTrue(result)
        XCTAssertTrue(failMessage.errors.count == 0)

    }
    
    func testRegexMatch() {
        let validation = Validation(name: "testValidation") { (context:Example) -> (AnyObject?) in
            return context.altProperty
        }
        let rule = RegexMatch(regex: "^aaa.+$")
        validation.addRule(rule)
        
        let example = Example()
        example.altProperty = "bbbbasdasd"
        var result = validation.runValidation(example)
        var failMessage = validation.allErrors()
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.errors.count > 0)
        
        example.altProperty = "aaabbbbasdasd"
        result = validation.runValidation(example)
        failMessage = validation.allErrors()
        XCTAssertTrue(result)
        XCTAssertTrue(failMessage.errors.count == 0)
    }
    
    
    func testValidEmail() {
        let validation = Validation(name: "testValidation") { (context:Example) -> (AnyObject?) in
            return context.altProperty
        }
        let rule = ValidEmail()
        validation.addRule(rule)
        
        let example = Example()
        example.altProperty = "wrongAT.email.it"
        var result = validation.runValidation(example)
        var failMessage = validation.allErrors()
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.errors.count > 0)
        
        example.altProperty = "info@frograin.com"
        result = validation.runValidation(example)
        failMessage = validation.allErrors()
        XCTAssertTrue(result)
        XCTAssertTrue(failMessage.errors.count == 0)
    }
}
