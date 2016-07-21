//
//  LocalizationHelper.swift
//  TestValidator
//
//  Created by FrogRain on 31/01/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

class LocalizationHelper {
    class func localizeThis(key:String) -> String {
        let mainBundle = NSBundle.mainBundle()
        var localizedString = NSLocalizedString(key, tableName: "object_validator_custom", bundle: mainBundle, comment:"")
        if(localizedString != key) {
            return localizedString
        }
        
        guard let frameworkPath = NSBundle(forClass: LocalizationHelper.self).resourcePath else {
            return key
        }
        guard let path = NSURL(string: frameworkPath)?.URLByAppendingPathComponent("FluidValidator.bundle").path else {
            return key
        }
        guard let bundle = NSBundle(path: path) else {
            return key
        }
        
        localizedString = NSLocalizedString(key, tableName: "object_validator", bundle: bundle, comment:"")
        
        if(localizedString != key) {
            return localizedString
        }
        
        return key
    }
}