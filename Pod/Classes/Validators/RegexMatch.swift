//
//  RegexMatch.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

public class RegexMatch: BeNotEmpty {
    private var regex:String
    
    public init(regex:String) {
        self.regex = regex
        super.init()
    }
    
    override public func performValidation(object: AnyObject?) -> Bool {
        if(!super.performValidation(object)) {
            return false
        }
        
        let test = NSPredicate(format: "SELF MATCHES %@", self.regex)
        return test.evaluateWithObject(object)
    }
}