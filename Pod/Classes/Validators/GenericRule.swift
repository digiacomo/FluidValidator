//
//  GenericRule.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

open class GenericRule: BeNotNil {
    fileprivate var genericCondition:(AnyObject) -> (Bool)
    
    public init(condition:@escaping (AnyObject) -> (Bool)) {
        self.genericCondition = condition
        super.init()
    }
    
    override open func performValidation(_ object: AnyObject?) -> Bool {
        if(!super.performValidation(object)) {
            return false
        }
        guard let object = object else {
            return false
        }
        return self.genericCondition(object)
    }
}
