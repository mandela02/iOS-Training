import UIKit

var str = "Hello, playground"

class Vehicle
{
    var numOfWheels = 0
    var description: String
    {
        return "\(numOfWheels) wheels"
    }
}

class Bike: Vehicle
{
    override init() {
        super.init()
        numOfWheels = 2
    }
}

class HoverBoard: Vehicle
{
    var color: String
    init(color: String)
    {
        self.color = color
        super.init()
        numOfWheels = 99
    }
    
    override var description: String
        {
        return "\(super.description) in a beautiful \(color)"
    }
}

var hover = HoverBoard(color: "Silver")
hover.description
var bike = Bike()
bike.description

class Food
{
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init()
    {
        self.init(name: "Unnamed")
    }
}

class Recipe: Food
{
    var quantity: Int
    init(name: String, quantity: Int)
    {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

var recipe_1 = Recipe()
recipe_1.name
recipe_1.quantity


class Person {
    var residence: Residence?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address
{
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func identifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

class Residence {
    
    var rooms = [Room]()
    var numOfRooms: Int{
        return rooms.count
    }
    subscript(i: Int) -> Room
    {
        get
        {
            return rooms[i]
        }
        set
        {
            rooms[i] = newValue
        }
    }
    
    func printNumOfRoom()  {
        print("The number of rooms is \(numOfRooms)")
    }
    var address: Address?
}

let address = Address()
address.buildingNumber = "30"
address.street = "Elm Street"

let wayne = Person()

let wayneHouse = Residence()
wayneHouse.rooms.append(Room(name: "Kitchen"))
wayne.residence = wayneHouse
wayne.residence?.address = address
wayne.residence?.address?.identifier()?.count

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

struct Item
{
    var price: Int
    var count: Int
}

class VendingMachine
{
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chip": Item(price: 10, count: 4),
        "Scooby": Item(price: 9, count: 11)
    ]
    
    var coinsDeposited = 0
    func vend(itemName name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispending \(name)")
    }
    
}

let favoriteSnacks = [
    "Batman": "Candy Bar",
    "Superman": "chip"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemName: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemName: name)
        self.name = name
    }
}


var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 9999999
do {
    try buyFavoriteSnack(person: "Batman", vendingMachine: vendingMachine)
    print("Success!")
} catch VendingMachineError.invalidSelection {
    print("invalid")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}


