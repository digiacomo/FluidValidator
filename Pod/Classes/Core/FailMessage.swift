//
//  FailMessage.swift
//  TestValidator
//
//  Created by FrogRain on 31/01/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

public class FailMessage : NSObject {
    
    public var summary:ErrorMessage
    
    public var errors:Array<ErrorMessage>
    
    private var opaqueDict:Dictionary<String, FailMessage>
    
    override init() {
        self.summary = ErrorMessage()
        self.errors = Array<ErrorMessage>()
        self.opaqueDict = Dictionary<String, FailMessage>()
        super.init()
    }
    
    public func failingFields () -> [String] {
        return self.opaqueDict.keys.map { (key) -> String in
            key
        }
    }
    
    func setObject(object:FailMessage, forKey:String) {
        self.opaqueDict[forKey] = object;
    }
    
    override public func valueForKeyPath(keyPath: String) -> AnyObject? {
        let dict = self.opaqueDict as NSDictionary
        return dict.valueForKeyPath(keyPath) as! FailMessage
    }
    
    public func failMessageForPath(keyPath: String) -> FailMessage? {
        return self.valueForKeyPath(keyPath) as? FailMessage
    }
}