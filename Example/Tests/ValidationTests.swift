//
//  TestValidatorTests.swift
//  TestValidatorTests
//
//  Created by FrogRain on 05/02/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import XCTest
import FluidValidator

class ValidationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidation() {
        let validation = Validation(name: "isTrue") { (context:Example) -> (AnyObject?) in
            return context.isTrue
        }
        let rule = BeNotNil()
        validation.addRule(rule)
        
        let example = Example()
        
        let result = validation.runValidation(example)
        
        let failMessage = validation.allErrors()
        
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.errors.count > 0)
    }
    
    func testConditionalValidation() {
        let validation = Validation(name: "test") { (context:Example) -> (AnyObject?) in
            return context.testProperty
        }
        
        validation.when { (context) -> (Bool) in
            return context.number == 0
        }
        
        validation.addRule(BeNotEmpty())
        
        let example = Example()
        example.number = 5
        example.testProperty = "" // It's empty!
        
        let result = validation.runValidation(example)
        
        XCTAssertTrue(result)
    }
}
