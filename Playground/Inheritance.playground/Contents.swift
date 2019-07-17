import UIKit

class Vehicle
{
    var currentSpeed = 0.0
    var Description: String
    {
        return "traveling at \(currentSpeed) miles"
    }
    func makeNoise() {
        print("Vroommm Vroommm")
    }
}

class Bicycler: Vehicle
{
    var gear = 1
    var hasBasket = true
    override func makeNoise() {
        print("Ding Ding Ding mdfk")
    }
    
    override var Description: String
    {
        return super.Description + " max speed at \(gear)"
    }
}
let bicycler = Bicycler()
bicycler.Description
bicycler.makeNoise()

class SuperBicycler: Bicycler
{
    override var currentSpeed: Double
    {
        didSet
        {
            gear = Int(currentSpeed/10 + 1)
        }
    }
}

let superBike = SuperBicycler()
superBike.currentSpeed = 9999
superBike.Description

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()

let originRect = Rect(origin: Point(x: 0, y: 0.1), size: Size(width: 1.01, height: 1.02))



