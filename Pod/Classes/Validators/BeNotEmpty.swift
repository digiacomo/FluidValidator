//
//  BeNotEmpty.swift
//  Pods
//
//  Created by FrogRain on 06/02/16.
//
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


open class BeNotEmpty : BeNotNil {
    override open func performValidation(onObject object: AnyObject?) -> Bool {
        if (!super.performValidation(onObject: object)) {
            return false
        }
        return object?.description.characters.count > 0
    }
}
