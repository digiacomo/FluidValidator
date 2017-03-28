//
//  GreaterThan.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

open class GreaterThan : BeNotNil {
    fileprivate var limit:NSNumber
    fileprivate var includeLimit:Bool
    
    public init(limit: NSNumber, includeLimit:Bool?) {
        self.limit = limit
        if let include = includeLimit {
            self.includeLimit = include
        }else{
            self.includeLimit = false
        }
        super.init()
    }
    
    override open func performValidation(_ object: AnyObject?) -> Bool {
        if(!super.performValidation(object)) {
            return false
        }else{
            guard let value = object as? NSNumber else {
                return false
            }
            var result = value.compare(self.limit) == .orderedDescending
            if(self.includeLimit){
                result = result || (value == self.limit)
            }
            return result
        }
    }
    
    override func errorMessage(_ subject: String, failValue: AnyObject?, context: AnyObject) -> String {
        let errMessage = self.errorTextLocalized()
        return String(format: errMessage, self.limit)
    }
    
    override func errorMessageExtended(_ subject: String, failValue: AnyObject?, context: AnyObject) -> String {        
        let errMessage = self.errorTextExtendedLocalized()
        return String(format: errMessage, subject, self.limit, self.optionalValueDescription(failValue))
    }
}
