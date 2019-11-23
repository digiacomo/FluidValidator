//
//  LowerThan.swift
//  Valid
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

final class LowerThan: Validatable {
    let max: Int
    
    func validate(value: Int) -> Bool {
        value < max
    }
    
    init(max: Int) {
        self.max = max
    }
}
