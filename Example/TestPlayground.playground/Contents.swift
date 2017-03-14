//: Playground - noun: a place where people can play

import UIKit
import FluidValidator

class Home {
    var isLocked:Bool?
    var number:Int?
    var ownerName:String?
    var garage: Garage?
    var floors: Array<Floor>?
}

class Garage {
    var isOpen: Bool?
    var maxCars: Int?
}

class Floor {
    var rooms: Int
    
    init(withMaxRooms maxRooms: Int) {
        rooms = maxRooms
    }
}

class FloorValidator: AbstractValidator<Floor> {
    override init() {
        super.init()
        
        self.addValidation("rooms") { (context) -> Any? in
            context.rooms
        }.addRule(GreaterThan(limit: 4, includeLimit: true))
    }
}

class GarageValidator: AbstractValidator<Garage> {
    override init() {
        super.init()
        
        self.addValidation("isOpen") { (context) -> Any? in
            context.isOpen
        }.addRule(BeTrue())
        
        self.addValidation("maxCars") { (context) -> Any? in
            context.maxCars
        }.addRule(GreaterThan(limit: 4, includeLimit: true))
    }
}

class HomeValidator : AbstractValidator<Home> {
    override init() {
        super.init()
        
        self.addValidation("number") { (context) -> Any? in
            context.number
        }.addRule(InRange(min: 4, max: 6, mode: ComparisonMode.MinMaxExluded))
        
        self.addValidation("ownerName") { (context) -> Any? in
            context.ownerName
        }.addRule(ValidEmail())
        
        self.addValidation("isLocked") { (context) -> Any? in
            context.isLocked
        }.addRule(BeTrue())
        
        self.addValidation("garage") { (context) -> (Any?) in
            context.garage
        }.addRule(GarageValidator())
        
        self.addValidation("floors") { (context) -> (Any?) in
            context.floors
        }.addRule(EnumeratorValidator(validatable: FloorValidator()))
    }
}

let home = Home()
home.isLocked = false
home.ownerName = "John Doe"
home.number = 3

let garage = Garage()
garage.isOpen = false
home.garage = garage

home.floors = []
home.floors?.append(Floor(withMaxRooms: 2))
home.floors?.append(Floor(withMaxRooms: 1))

let homeValidator = HomeValidator()
let result = homeValidator.validate(home)
let failMessage = homeValidator.allErrors()

failMessage.failMessageForPath("ownerName")?.errors.first?.compact
failMessage.failMessageForPath("ownerName")?.errors.first?.extended

failMessage.failMessageForPath("isLocked")?.errors.first?.compact
failMessage.failMessageForPath("isLocked")?.errors.first?.extended

failMessage.failMessageForPath("number")?.errors.first?.compact
failMessage.failMessageForPath("number")?.errors.first?.extended

failMessage.failMessageForPath("garage")?.errors.first?.compact
failMessage.failMessageForPath("garage")?.errors.first?.extended

failMessage.failMessageForPath("garage.isOpen")?.errors.first?.compact
failMessage.failMessageForPath("garage.isOpen")?.errors.first?.extended

failMessage.failMessageForPath("floors")?.errors.first?.compact
failMessage.failMessageForPath("floors")?.errors.first?.extended

home.floors?.first?.rooms

failMessage.failMessageForPath("floors.1.rooms")?.errors.first?.extended

