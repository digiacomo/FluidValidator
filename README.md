# FluidValidator

[![CI Status](http://img.shields.io/travis/FrogRain/FluidValidator.svg?style=flat)](https://travis-ci.org/FrogRain/FluidValidator)
[![Version](https://img.shields.io/cocoapods/v/FluidValidator.svg?style=flat)](http://cocoapods.org/pods/FluidValidator)
[![License](https://img.shields.io/cocoapods/l/FluidValidator.svg?style=flat)](http://cocoapods.org/pods/FluidValidator)
[![Platform](https://img.shields.io/cocoapods/p/FluidValidator.svg?style=flat)](http://cocoapods.org/pods/FluidValidator)

## Description
FluidValidator is intended to encapsulate validation logic. The API was designed with FluentValidation (https://github.com/JeremySkinner/FluentValidation) and Rails Validation as reference.
  Currently offers validation of simple objects, complex objects (object graph), enumerables. Localized error messages. You can easly override base behaviors and/or build your own reusable validation rules.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
No special requirements

## Installation

FluidValidator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FluidValidator"
```

## Usage
### A simple object
Given this object:

```swift

import Foundation

class Home {
    var isLocked:Bool?
    var number:Int?
    var ownerName:String?
}
```

Create a custom validator extending AbstractValidator specifing target class Example:

```swift

import Foundation
import FluidValidator

class HomeValidator : AbstractValidator<Home> {
    override init() {
        super.init()
               
        self.addValidation(withName: "number") { (context) -> (Any?) in
            context.number
        }.addRule(GreaterThan(limit: 3, includeLimit: false))
        
        self.addValidation(withName: "ownerName") { (context) -> (Any?) in
            context.ownerName
        }.addRule(BeNotEmpty())
        
        self.addValidation(withName: "isLocked") { (context) -> (Any?) in
            context.isLocked
        }.addRule(BeTrue())
    }
}
```
### Nested Objects
Given this more complex object:
```swift
import Foundation

class Home {
    var isLocked:Bool?
    var number:Int?
    var ownerName:String?
    var garage: Garage?
}
class Garage {
  var isOpen: Bool?
  var maxCars: Int?
}
```
The corresponding validator would be implemented this way:
```swift
import Foundation
import FluidValidator

class GarageValidator: AbstractValidator<Garage> {
    override init() {
        super.init()
        
        self.addValidation(withName: "isOpen") { (context) -> Any? in
            context.isOpen
        }.addRule(BeTrue())
        
        self.addValidation(withName: "maxCars") { (context) -> Any? in
            context.maxCars
        }.addRule(LessThan(limit: 2, includeLimit: true))
    }
}

class HomeValidator : AbstractValidator<Home> {
    override init() {
        super.init()
        
        ...
        self.addValidation(withName: "garage") { (context) -> (Any?) in
            context.garage
        }.addRule(GarageValidator())
    }
}
```

### Run validations and get result

regardless of your validators complexity, you can run validation process and extract error messages (if any) as showed here

```swift

    let garage = Garage()
    garage.isOpen = false

    let home = Home()
    home.isLocked = true
    home.ownerName = "John Doe"
    home.number = 2
    home.garage = garage

    let homeValidator = HomeValidator()
    let result = homeValidator.validate(home)
    let failMessage = homeValidator.allErrors()
```

### Get fail messages
```swift
failMessage.failMessageForPath("number")?.errors.first?.compact
failMessage.failMessageForPath("number")?.errors.first?.extended

failMessage.failMessageForPath("garage")?.errors.first?.compact
failMessage.failMessageForPath("garage.isOpen")?.errors.first?.extended
```
The errors array contains ErrorMessage objects which in turn contains compact and extended error message.

Take a look at Unit Test classes to figure out other features



## Author

FrogRain, info@frograin.com

## License

FluidValidator is available under the MIT license. See the LICENSE file for more info.
