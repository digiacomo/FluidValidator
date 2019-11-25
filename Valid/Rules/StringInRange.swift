//
//  StringInRange.swift
//  Valid
//
//  Created by Antonio Di Giacomo on 25/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

final class StringInRange: Validatable {
    var errorMessage: String = "String not in range"
    
    let minLength: Int
    let maxLength: Int
    
    init(minLength: Int, maxLength: Int) {
        self.minLength = minLength
        self.maxLength = maxLength
    }
    
    func validate(value: String) -> Bool {
        guard value.count <= maxLength,
            value.count > minLength else {
            return false
        }
        return true
    }
}
