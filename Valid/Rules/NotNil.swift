//
//  NotNil.swift
//  Valid
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

struct NotNil<T>: Validatable {
    func validate(value: Optional<T>) -> Bool {
        switch value {
        case .none:
            return false
        case .some:
            return true
        }
    }
}
