//
//  NotEmpty.swift
//  Valid
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

final class NotEmpty: Validatable {
    func validate(value: String?) -> Bool {
        guard let value = value else {
            return false
        }
        return value.count > 0
    }
}
