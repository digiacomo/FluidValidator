//
//  FluidValidatorTests.swift
//  FluidValidator
//
//  Created by FrogRain on 06/02/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


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
        let result = validator.validate(object: example)
        let failMessage = validator.allErrors

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
        let result = validator.validate(object: container)
        let failMessage = validator.allErrors
        
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.failMessageForPath("test")?.errors.count > 0)
        XCTAssertTrue(failMessage.failMessageForPath("example")?.errors.count > 0)
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
        let result = validator.validate(object: container)
        let failMessage = validator.allErrors
        
        XCTAssertFalse(result)
        XCTAssertTrue(failMessage.failMessageForPath("arrExample.0.number")!.errors.count > 0)
        XCTAssertTrue(failMessage.failMessageForPath("arrExample.1.number")!.errors.count > 0)
    }
    
    func testMultipleRulesOnSameProperty() {
        let example = Example()
        example.number = 5
        let validator = ExampleValidator2()
        let result = validator.validate(object: example)
        let _ = validator.allErrors
        XCTAssertTrue(result)
    }
}
