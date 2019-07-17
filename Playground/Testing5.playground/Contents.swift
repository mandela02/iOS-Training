import UIKit


struct Point
{
    var x = 0.0
    var y = 0.0
//    mutating func update(x deltaX: Double, y deltaY: Double)
//    {
//        x += deltaX
//        y += deltaY
//    }
    mutating func update(x deltaX: Double, y deltaY: Double)
    {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

var fixedPoint = Point(x: 3.0, y: 3.0)
fixedPoint.update(x: 2.0, y: 2.0)

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next()


let name: [String] = ["Batman", "Superman", "Flash", "Arrow"]
var sortedName1 = name.sorted(by:
{
    (s1: String, s2: String) -> Bool in return s1 > s2
    }
)
sortedName1

var sortedName2 = name.sorted(by: {
    $0 > $1
})
var sortedName3 = name.sorted(by: {
    s1, s2 in s1 > s2
})

var sortedName4 = name.sorted(by: >)

enum Robins: CaseIterable
{
    case Nightwing,RedRobin, RedHood, DamianWayne;
}

var firstRobin = Robins.Nightwing;
firstRobin = .DamianWayne;
firstRobin = .RedHood
switch firstRobin {
case .Nightwing:
    print("Name: Dick Grayson")
    break
case .RedRobin:
    print("Name: Tim Drake")
    break
//case .RedHood:
//    print("Name: Jason Todd")
//    break
case .DamianWayne:
    print("Name: Damian Wayne")
    break
default:
    print("dead")
}

for robin in Robins.allCases {
    print(robin)
}

enum Barcode
{
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var code = Barcode.upc(1, 2, 3, 4)
code = .qrCode("IAMBATMAN")

enum NewRobin: String
{
    case Nightwing,RedRobin, RedHood, DamianWayne;
}

var robin = NewRobin.RedHood.rawValue

let possibleRobin = NewRobin(rawValue: "ReedHood")

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var position: Int?
position = 11
if let planet = Planet(rawValue: position!)
{
    switch planet
    {
    case .earth:
        print("harmless")
    default:
        print("Dangerous")
    }
}
else
{
    print("no planet at \(position!)")
}

let stuff = {print("Stuff")}
stuff()

let add: (Int, Int) -> Int = {
    (a: Int, b: Int) ->Int in return a + b
}
add(1,2)

let add2: (Int, Int) -> Int = {$0 + $1}
add2(1,2)
let add3 = {
    (a: Int, b:Int) -> Int in a + b
}
add3(1,2)
