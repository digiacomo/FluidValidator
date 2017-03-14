//
//  BeTrue.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

open class BeTrue : BeNotNil {
    
    override open func performValidation(_ object: AnyObject?) -> Bool {
        if(!super.performValidation(object)){
            return false
        }
        return object as? Bool ?? false
    }
    
    override func optionalValueDescription(_ value: AnyObject?) -> String {
        let valueDescription = value as? Bool ?? false
        return valueDescription ? "active" : "not active"
    }
}
