//
//  ValidEmail.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

open class ValidEmail: RegexMatch {
    public init() {
        let regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
        super.init(regex: regex)
    }
    
    override open func performValidation(onObject object: AnyObject?) -> Bool {
        return super.performValidation(onObject: object)
    }
}
