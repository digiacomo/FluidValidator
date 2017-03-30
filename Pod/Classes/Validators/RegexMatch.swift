//
//  RegexMatch.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

open class RegexMatch: BeNotEmpty {
    fileprivate var regex:String
    
    public init(regex:String) {
        self.regex = regex
        super.init()
    }
    
    override open func performValidation(onObject object: AnyObject?) -> Bool {
        if(!super.performValidation(onObject: object)) {
            return false
        }
        
        let test = NSPredicate(format: "SELF MATCHES %@", self.regex)
        return test.evaluate(with: object)
    }
}
