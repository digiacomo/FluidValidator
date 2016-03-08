//
//  GenericRule.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

public class GenericRule: BeNotNil {
    private var genericCondition:(AnyObject) -> (Bool)
    
    public init(condition:(AnyObject) -> (Bool)) {
        self.genericCondition = condition
        super.init()
    }
    
    override public func performValidation(object: AnyObject?) -> Bool {
        if(!super.performValidation(object)) {
            return false
        }
        
        return self.genericCondition(object!)
    }
}