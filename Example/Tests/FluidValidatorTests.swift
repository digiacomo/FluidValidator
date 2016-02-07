//
//  FluidValidatorTests.swift
//  FluidValidator
//
//  Created by FrogRain on 06/02/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

class FluidValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimpleObject() {
        let example = Example()
        example.testProperty = nil
        example.altProperty = ""
        example.number = 3
        example.isTrue = false
        
        let validator = ExampleValidator()
        let result = validator.validate(example)
        let failMessage = validator.allErrors()

        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.failingFields().count > 0)
    }
    
    func testNestedObject() {
        let example = Example()
        example.testProperty = nil
        example.altProperty = ""
        example.number = 3
        example.isTrue = false
        
        let container = ContainerObject()
        container.test = ""
        container.example = example
        
        let validator = ContainerValidator()
        let result = validator.validate(container)
        let failMessage = validator.allErrors()
        
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.failMessageForPath("test")?.errors.count > 0)
        XCTAssertTrue(failMessage.failMessageForPath("example.number")?.errors.count > 0)
    }
    
    func testValidatableOnEnumerable() {
        let example = Example()
        example.testProperty = nil
        example.altProperty = ""
        example.number = 3
        example.isTrue = false
        
        let container = ListContainer()
        container.string = ""
        container.arrExample = [example, example, example]
        
        let validator = ListContainerValidator()
        let result = validator.validate(container)
        let failMessage = validator.allErrors()
        
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.failMessageForPath("arrExample.0.number")!.errors.count > 0)
        XCTAssertTrue(failMessage.failMessageForPath("arrExample.1.number")!.errors.count > 0)
    }
}
