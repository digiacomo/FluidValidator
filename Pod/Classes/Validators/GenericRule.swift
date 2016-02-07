//
//  GenericRule.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

class GenericRule: BeNotNil {
    private var genericCondition:(AnyObject) -> (Bool)
    
    init(condition:(AnyObject) -> (Bool)) {
        self.genericCondition = condition
        super.init()
    }
    
    override func performValidation(object: AnyObject?) -> Bool {
        if(!super.performValidation(object)) {
            return false
        }
        
        return self.genericCondition(object!)
    }
}