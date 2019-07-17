import UIKit

var x = 10
var y = 10
func calSum(x: Int, y: Int) -> Int
{
    let sum = x + y
    if x == y
    {
        return sum*3
    }
    else {
        return sum
    }
}

func diff51(x: Int) -> Int
{
    let i = x - 51
    if x > 51
    {
        return i*2
    }
    else
    {
        return -i
    }
}

func compare20(x: Int, y: Int) -> Bool
{
    if x == 20 || y == 20 || x + y == 20
    {
        return true
    }
    else {
        return false
    }
}

func hasIsInIt(string: String) -> String
{
    if string.hasPrefix("is")
    {
        return string
    }
    else
    {
        return "is \(string)"
    }
}


func negativeChecker(x: Int, y: Int) -> Bool
{
    if x > 0 && y > 0
    {
        return false
    }
    else
    {
        return true
    }
}

func removeChar(str: String, x: Int) -> String
{
    var newStr = str
    newStr.remove(at: str.index(str.startIndex, offsetBy: x))
    return newStr
}

func switchChar(str: String) -> String
{
    var newString = str
    //var firstChar = newString[newString.startIndex]
    var firstChar = newString.remove(at: newString.startIndex)
    //var lastChar = newString[newString.index(before: newString.endIndex)]
    var lastChar = newString.remove(at: newString.index(before: newString.endIndex))
    newString.append(firstChar)
    newString.insert(lastChar, at: newString.startIndex)
    return newString
}

func addChar(str: String) -> String
{
    var newString = str;
    var lastChar = newString[newString.index(before: newString.endIndex)]
    newString.append(lastChar)
    newString.insert(lastChar, at: newString.startIndex)
    return newString
}

func checkMultiple5of3(x: Int)
{
    if x%3 == 0
    {
        print("\(x) is a mutiple of 3")
    }
    else if x%5 == 0
    {
        print("\(x) is a mutiple of 5")
    }
    else
    {
        print("HAIL HITLER")
    }
}

func insert2Char(str: String) -> String
{
    let newStr = str
    let twoChar = newStr.prefix(2)
    return String(twoChar) + newStr + String(twoChar)
}

func isBeginWithFix(str: String) -> Bool
{
    var newStr = str
    var _ = newStr.remove(at: newStr.startIndex)
    if newStr.hasPrefix("ix")
    {
        return true
    }
    else
    {
        return false
    }
}

func findLargest(x: Int, y: Int, z: Int) -> Int
{
    if x > y && x > z
    {
        return x
    }
    else if y > x && y > z
    {
        return y
    }
    else if z > x && z > y
    {
        return z
    }
    
    else if x == y && x > z
    {
        return x
    }
    else if x == z && x > y
    {
        return x
    }
    else
    {
        return y
    }
}

print(calSum(x: x, y: y))
print(diff51(x: 52))
print(compare20(x: 10, y: 0))
hasIsInIt(string: "Batman")
print(negativeChecker(x: -1, y: -1))
print(negativeChecker(x: 1, y: 1))
print(negativeChecker(x: -1, y: 1))
print(negativeChecker(x: 1, y: -1))
print(removeChar(str: "Batman", x: 0))
switchChar(str: "Batman")
addChar(str: "Batman")
checkMultiple5of3(x: 99)
insert2Char(str: "batman")
print(isBeginWithFix(str: "fix metallo"))
print(isBeginWithFix(str: "gix metallo"))
print(isBeginWithFix(str: "lix metallo"))
print(isBeginWithFix(str: "flex metallo"))
findLargest(x: 9999, y: 44, z: 9999)
