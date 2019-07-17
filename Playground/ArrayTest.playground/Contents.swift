import UIKit

var intArray = [Int]()
var intArray2 = [1, 2, 3]
var stringArray: [String] = ["Batman", "Superman"]
//intArray.append(3)
var intArrayCombine = intArray2 + intArray
intArray = intArray2
var intSix = Array(repeating: "Batman", count: 6)
intSix.count
intArray2.count
intSix[intSix.index(intSix.startIndex, offsetBy: 3)]
var stringArray2 = ["Batman", "Superman"]
stringArray2 += ["Green Lantern", "Aquaman", "Cyborg", "Wonder Woman"]
stringArray2 += ["Flash"]
stringArray2[2...stringArray2.count-1] = ["Martian Manhunter"]
stringArray2.insert("Zatanna", at: 0)
//stringArray2.remove(at: 3)
//stringArray2.removeLast()
//stringArray2.removeAll()
//stringArray2
for item in stringArray2 {
    print(item + " ", terminator: "")
}
for (index, value) in stringArray2.enumerated() {
    print("\(index + 1): \(value)")
}

var favoriteHeroes: Set<String> = ["Batman", "Superman" , "Wonder Woman"]
favoriteHeroes.insert("Flash")
favoriteHeroes
favoriteHeroes.remove("Batman")
favoriteHeroes
favoriteHeroes.remove("Green Arrow")

for hero in favoriteHeroes.sorted() {
    print(hero)
}
let odd: Set = [1,3,5,7,9]
let even: Set = [2,4,6,8,10]
let random: Set = [1,2,3,4,5,6]
odd.intersection(even)
odd.union(even)
odd.symmetricDifference(even)
odd.subtracting(random)

var heroesRanks = [Int: String]()

heroesRanks[1] = "Superman"

var heroesRanks2: [Int: String] = [1: "Superman", 2: "Batman", 3: "Flash"]

if let oldValue = heroesRanks2.updateValue("Green Lantern", forKey: 2)
{
    print(oldValue)
}

heroesRanks2.removeValue(forKey: 3)

let hero1 = heroesRanks2[2]

for hero in heroesRanks2.values {
    print(hero)
}
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")

stringArray2
for hero in stringArray2[1..<3]
{
    print(hero)
}
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval)
{
    print(tickMark)
    
}
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint
{
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

