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

class Example {
    var isTrue:Bool?
    var number:Int?
    var testProperty:String?
    var altProperty:String?
}
```

Create a custom validator extending AbstractValidator specifing target class Example:

```swift

import Foundation
import FluidValidator

class ExampleValidator : AbstractValidator<Example> {
    override init() {
        super.init()
        
        self.addValidation("testProperty") { (context) -> (AnyObject?) in
            context.testProperty
        }.addRule(BeNotNil())
        
        self.addValidation("altProperty") { (context) -> (AnyObject?) in
            context.altProperty
        }.addRule(BeNotEmpty())
        
        self.addValidation("isTrue") { (context) -> (AnyObject?) in
            context.isTrue
        }.addRule(BeTrue())
        
        self.addValidation("number") { (context) -> (AnyObject?) in
            context.number
        }.addRule(LessThan(limit: 3, false))
    }
}
```
### Nested Objects
Given this more complex object:
```swift
import Foundation

class ContainerObject {
    var example:Example?
    var test:String?
}
```
The corresponding validator would be implemented this way:
```swift
import Foundation
import FluidValidator

class ContainerValidator : AbstractValidator<ContainerObject> {
    override init() {
        super.init()
        self.addValidation("test") { (context) -> (AnyObject?) in
            context.test
        }.addRule(BeNotEmpty())
        
        self.addValidation("example") { (context) -> (AnyObject?) in
            context.example
        }.addRule(ExampleValidator())
    }
}
```

### Run validations and get result

regardless of your validators complexity, you can run validation process and extract error messages (if any) as showed here

```swift

	let example = Example()
	example.testProperty = nil
	example.altProperty = ""
	example.number = 3
	example.isTrue = false

	let validator = ExampleValidator()
	let result = validator.validate(example)
	let failMessage = validator.allErrors()
```

### Get fail messages
```swift
failMessage.failMessageForPath("test")?.errors.first.compact
failMessage.failMessageForPath("test")?.errors.first.extended
failMessage.failMessageForPath("example")?.errors.first.compact
failMessage.failMessageForPath("example")?.errors.first.extended
failMessage.failMessageForPath("example.number")?.errors.first.compact
failMessage.failMessageForPath("example.number")?.errors.first.extended
```
The errors array contains ErrorMessage objects which in turn contains compact and extended error message.

Take a look at Unit Test classes to figure out other features



## Author

FrogRain, info@frograin.com

## License

FluidValidator is available under the MIT license. See the LICENSE file for more info.
