//
//  BeTrue.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

public class BeTrue : BeNotNil {
    
    override public func performValidation(object: AnyObject?) -> Bool {
        if(!super.performValidation(object)){
            return false
        }
        return object as? Bool ?? false
    }
}