import UIKit

var str = "Hello, playground"

protocol Delegate {
    func passData(data:String) -> String
}

class Boss {
    var delegate: Delegate?
    var rewind: String?
}

class Secretary: Delegate {
    func passData(data: String) -> String {
        print("boss said \(data)")
        return "i said fuck u boss"
    }
}

var boss = Boss()
var sec = Secretary()
boss.delegate = sec
boss.rewind = boss.delegate?.passData(data: "ello")
print(boss.rewind!)


protocol Vehicle: CustomStringConvertible {
    var isRunning: Bool {get set}
    var make: String {get set}
    var model: String {get set}
    mutating func start()
    mutating func shutDown()
}
extension Vehicle {
    var makeModel: String {
        return "\(make) \(model)"
    }
    
    mutating func start() {
        if isRunning {
            print("\(self.description) Already start")
        } else {
            isRunning = true
            print("\(self.description) starting now ... VROOOOOOOMMMMMM ...")
        }
    }
    
    mutating func shutDown() {
        if isRunning {
            isRunning = false
            print("\(self.description) stop now ... stopped ")
        } else {
            print("\(self.description) already stop")
        }
    }

}
struct SportCar: Vehicle {
    var make: String
    var model: String
    var description: String {
    return self.makeModel
    }
    var isRunning: Bool = false
    init(make: String, model: String) {
        self.make = make
        self.model = model
    }
}

class Truck: Vehicle {
    var make: String
    var model: String
    var description: String {
    return self.makeModel
    }
    var isRunning: Bool = false
    
    init(make: String, model: String) {
        self.make = make
        self.model = model
    }
    
    
    func airHorn() {
        print("TOOOOOOT ..... :]")
    }
}

extension Double {
    var Dollar: String {
        //return "$\(self)"
        return String(format: "$%0.2f", self)
    }
}

var car = SportCar(make: "Ducanger", model: "1975")
var truck = Truck(make: "Tran", model: "Dan")

car.start()
car.shutDown()

truck.start()
truck.shutDown()

var listOfCars: [Vehicle] = [car, truck]

for auto in listOfCars {
    if let auto = auto as? Truck {
        auto.airHorn()
    }
}

var money = 2.2222
money.Dollar


protocol reusable: class {
    func blabla()
}

class notReuse: reusable {
    func blabla() {
        print("bla")
    }
    
    
}
