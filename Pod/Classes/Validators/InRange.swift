//
//  InRange.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

open class InRange : BeNotNil {
    fileprivate var min:NSNumber
    fileprivate var max:NSNumber
    fileprivate var comparisonMode:ComparisonMode = ComparisonMode.MinMaxExluded
    
    public init(min:NSNumber, max:NSNumber, mode:ComparisonMode) {
        self.min = min
        self.max = max
        self.comparisonMode = mode
        super.init()
    }
    
    override open func performValidation(_ object: AnyObject?) -> Bool {
        if (!super.performValidation(object)) {
            return false
        }
        guard let value = object as? NSNumber else {
            return false
        }
        
        var lowerLimit = value.compare(min) == .orderedDescending
        if(self.comparisonMode.contains(ComparisonMode.MinIncluded)) {
            lowerLimit = lowerLimit || value.compare(min) == .orderedSame
        }
        
        var higherLimit = value.compare(max) == .orderedAscending
        if(self.comparisonMode.contains(ComparisonMode.MaxIncluded)) {
            higherLimit = higherLimit || value.compare(max) == .orderedSame
        }

        return lowerLimit && higherLimit
    }
    
    override func errorMessage(_ subject: String, failValue: AnyObject?, context: AnyObject) -> String {
        let errMessage = self.errorTextLocalized()
        return String(format: errMessage, subject, self.min, self.max, self.optionalValueDescription(failValue))
    }
    
    override func errorMessageExtended(_ subject: String, failValue: AnyObject?, context: AnyObject) -> String {
        let errMessage = self.errorTextExtendedLocalized()
        return String(format: errMessage, subject, self.min, self.max, self.optionalValueDescription(failValue))
    }
}

public struct ComparisonMode : OptionSet{
    public let rawValue : Int
    public init(rawValue:Int){ self.rawValue = rawValue}
    
    public static let MinMaxExluded  = ComparisonMode(rawValue:1)
    public static let MinIncluded  = ComparisonMode(rawValue:2)
    public static let MaxIncluded = ComparisonMode(rawValue:4)
}
