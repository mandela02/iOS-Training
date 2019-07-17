import UIKit

class Counter
{
    var count: Int = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int){
        count += amount
    }
    func reset() {
        count = 0
    }
}

var obj = Counter()
var obj_2 = obj
obj.increment()
obj.increment()
obj.increment()
obj.increment()
obj_2.count

struct Counter_2
{
    var count = 0
    mutating func increment() {
        self.count += 1
    }
    mutating func increment(by amount: Int){
        self.count += amount
    }
    mutating func reset() {
        self.count = 0
    }
}

var obj_3 = Counter_2()
var obj_4 = obj_3

obj_3.increment()
obj_3.increment()
obj_3.increment()
obj_3.increment()
obj_3.increment()
obj_3.count
obj_4.count

//this shit cool af

struct LvlTracker
{
    static var highestUnlockedLvl = 1
    var currentLvl = 1
    
    static func unlock(level: Int)
    {
        if level > highestUnlockedLvl
        {
            highestUnlockedLvl = level
        }
    }
    static func isUnlocked(level : Int) -> Bool
    {
        return level <= highestUnlockedLvl
    }
    
    mutating func advance(to level: Int) -> Bool {
        if LvlTracker.isUnlocked(level: level)
        {
            currentLvl = level
            return true
        }
        else
        {
            return false
        }
    }
}

class Player
{
    var tracker = LvlTracker()
    let playerName: String
    func complete(level: Int)
    {
        LvlTracker.unlock(level: level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Batman")
player.complete(level: 1)
print("highest unlocked level of\(player.playerName) is now \(LvlTracker.highestUnlockedLvl)")
var player_2 = Player(name: "Superman")
player_2.complete(level: 3)
print("highest unlocked level of\(player_2.playerName) is now \(LvlTracker.highestUnlockedLvl)")


struct TimeTable
{
    let multiplier: Int
    subscript (index: Int) -> Int
    {
        return multiplier * index
    }
}

let three = TimeTable(multiplier: 3)
print(three[6])

//????

struct Matrix
{
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows*columns)
    }
    func isValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row <= rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double
    {
        get
        {
            assert(isValid(row: row, column: column), "out of range")
            return grid[(row * columns) + column]
        }
        set
        {
            assert(isValid(row: row, column: column), "out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var newMatrix = Matrix(rows: 2, columns: 2)
newMatrix[1, 1] = 12

//enum Planet: Int
//{
//    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
//     subscript(n: Int) -> Planet
//    {
//        return Planet(rawValue: n)
//    }
//}
//
//let Mars = Planet[4]

