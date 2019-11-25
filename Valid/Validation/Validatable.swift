//
//  Validatable.swift
//  Valid
//
//  Created by Antonio Di Giacomo on 23/11/2019.
//  Copyright © 2019 Antonio Di Giacomo. All rights reserved.
//

import Foundation

protocol Validatable: class {
    associatedtype ValueType
    func validate(value: ValueType) -> Bool
    var errorMessage: String { get }
}
