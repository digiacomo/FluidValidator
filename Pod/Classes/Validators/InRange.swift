//
//  InRange.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation

public class InRange : BeNotNil {
    private var min:NSNumber
    private var max:NSNumber
    private var comparisonMode:ComparisonMode = ComparisonMode.MinMaxExluded
    
    public init(min:NSNumber, max:NSNumber, mode:ComparisonMode) {
        self.min = min
        self.max = max
        self.comparisonMode = mode
        super.init()
    }
    
    override public func performValidation(object: AnyObject?) -> Bool {
        if (!super.performValidation(object)) {
            return false
        }
        guard let value = object as? NSNumber else {
            return false
        }
        
        var lowerLimit = value.compare(min) == .OrderedDescending
        if(self.comparisonMode.contains(ComparisonMode.MinIncluded)) {
            lowerLimit = lowerLimit || value.compare(min) == .OrderedSame
        }
        
        var higherLimit = value.compare(max) == .OrderedAscending
        if(self.comparisonMode.contains(ComparisonMode.MaxIncluded)) {
            higherLimit = higherLimit || value.compare(max) == .OrderedSame
        }

        return lowerLimit && higherLimit
    }
    
    override func errorMessage(subject: String, failValue: AnyObject?, context: AnyObject) -> String {
        let errMessage = self.errorTextLocalized()
        return String(format: errMessage, subject, self.min, self.max, self.optionalValueDescription(failValue))
    }
    
    override func errorMessageExtended(subject: String, failValue: AnyObject?, context: AnyObject) -> String {
        let errMessage = self.errorTextExtendedLocalized()
        return String(format: errMessage, subject, self.min, self.max, self.optionalValueDescription(failValue))
    }
}

public struct ComparisonMode : OptionSetType{
    public let rawValue : Int
    public init(rawValue:Int){ self.rawValue = rawValue}
    
    public static let MinMaxExluded  = ComparisonMode(rawValue:1)
    public static let MinIncluded  = ComparisonMode(rawValue:2)
    public static let MaxIncluded = ComparisonMode(rawValue:4)
}