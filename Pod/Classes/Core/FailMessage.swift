//
//  FailMessage.swift
//  TestValidator
//
//  Created by FrogRain on 31/01/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

open class FailMessage : NSObject {
    
    open var summary:ErrorMessage
    open var localizedSubject:String?
    
    open var errors:Array<ErrorMessage>
    
    fileprivate var opaqueDict:Dictionary<String, FailMessage>
    
    override init() {
        self.summary = ErrorMessage()
        self.errors = Array<ErrorMessage>()
        self.opaqueDict = Dictionary<String, FailMessage>()
        super.init()
    }
    
    open func failingFields () -> [String] {
        return self.opaqueDict.keys.map { (key) -> String in
            key
        }
    }
    
    func setObject(_ object:FailMessage, forKey:String) {
        self.opaqueDict[forKey] = object;
    }
    
    override open func value(forKeyPath keyPath: String) -> Any? {
        let dict = self.opaqueDict as NSDictionary
        return dict.value(forKeyPath: keyPath) as? FailMessage
    }
    
    open func failMessageForPath(_ keyPath: String) -> FailMessage? {
        return self.value(forKeyPath: keyPath) as? FailMessage
    }
}
