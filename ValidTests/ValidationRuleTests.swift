//
//  ValidationRuleTests.swift
//  ValidTests
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

import XCTest
@testable import Valid

class ValidationRuleTests: XCTestCase {
    func testGreaterThan() {
        let gt = GreaterThan(max: 1)
        XCTAssertTrue(gt.validate(value: 5))
    }
}
