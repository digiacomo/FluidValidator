//
//  LessThan.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

open class LessThan : BeNotNil {
    fileprivate var limit:NSNumber
    fileprivate var includeLimit:Bool
    
    public init(limit: NSNumber, includeLimit include:Bool = false) {
        self.limit = limit
        self.includeLimit = include
        super.init()
    }
    
    override open func performValidation(onObject object: AnyObject?) -> Bool {
        if(!super.performValidation(onObject: object)) {
            return false
        }else{
            guard let value = object as? NSNumber else {
                return false
            }
            var result = value.compare(self.limit) == .orderedAscending
            if(self.includeLimit){
                result = result || (value == self.limit)
            }
            return result
        }
    }
    
    override func errorMessage(_ subject: String, failValue: AnyObject?, context: AnyObject) -> String {
        let errMessage = self.errorTextLocalized()
        return String(format: errMessage, subject, self.limit, self.optionalValueDescription(failValue))
    }
    
    override func errorMessageExtended(_ subject: String, failValue: AnyObject?, context: AnyObject) -> String {
        let errMessage = self.errorTextExtendedLocalized()
        return String(format: errMessage, subject, self.limit, self.optionalValueDescription(failValue))
    }
}
