//
//  ValidEmail.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

public class ValidEmail: RegexMatch {
    public init() {
        let regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
        super.init(regex: regex)
    }
    
    override public func performValidation(object: AnyObject?) -> Bool {
        return super.performValidation(object)
    }
}