//
//  BeNotEmpty.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

public class BeNotEmpty : BeNotNil {
    override public func performValidation(object: AnyObject?) -> Bool {
        if (!super.performValidation(object)) {
            return false
        }
        return object?.description.characters.count > 0
    }
}