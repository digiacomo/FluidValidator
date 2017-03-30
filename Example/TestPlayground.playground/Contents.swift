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
        
        self.addValidation(withName: "garage") { (context) -> (Any?) in
            context.garage
        }.addRule(GarageValidator())
        
        self.addValidation(withName: "floors") { (context) -> (Any?) in
            context.floors
        }.addRule(EnumeratorValidator(validatable: FloorValidator()))
    }
}

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

class FloorValidator: AbstractValidator<Floor> {
    override init() {
        super.init()
        
        self.addValidation(withName: "rooms") { (context) -> Any? in
            context.rooms
        }.addRule(GreaterThan(limit: 4, includeLimit: true))
    }
}

let garage = Garage()
garage.isOpen = false

let floor_1 = Floor(withMaxRooms: 2)
let floor_2 = Floor(withMaxRooms: 3)

let home = Home()
home.isLocked = true
home.ownerName = "John Doe"
home.number = 2
home.garage = garage
home.floors = [floor_1, floor_2]

let homeValidator = HomeValidator()
let result = homeValidator.validate(object: home)
let failMessage = homeValidator.allErrors

failMessage.failMessageForPath("number")?.errors.first?.compact
failMessage.failMessageForPath("number")?.errors.first?.extended

failMessage.failMessageForPath("garage")?.errors.first?.compact
failMessage.failMessageForPath("garage.isOpen")?.errors.first?.extended

failMessage.failMessageForPath("floors")?.errors.first?.compact
failMessage.failMessageForPath("floors.0.rooms")?.errors.first?.extended

