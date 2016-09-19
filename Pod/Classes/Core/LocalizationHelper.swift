//
//  LocalizationHelper.swift
//  TestValidator
//
//  Created by FrogRain on 31/01/16.
//  Copyright © 2016 FrogRain. All rights reserved.
//

import Foundation

class LocalizationHelper {
    class func localizeThis(_ key:String) -> String {
        let mainBundle = Bundle.main
        var localizedString = NSLocalizedString(key, tableName: "object_validator_custom", bundle: mainBundle, comment:"")
        if(localizedString != key) {
            return localizedString
        }
        
        guard let frameworkPath = Bundle(for: LocalizationHelper.self).resourcePath else {
            return key
        }
        guard let path = URL(string: frameworkPath)?.appendingPathComponent("FluidValidator.bundle").path else {
            return key
        }
        guard let bundle = Bundle(path: path) else {
            return key
        }
        
        localizedString = NSLocalizedString(key, tableName: "object_validator", bundle: bundle, comment:"")
        
        if(localizedString != key) {
            return localizedString
        }
        
        return key
    }
}
