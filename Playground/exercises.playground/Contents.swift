import UIKit

//Ques 1
func sum2int(x: Int, y: Int) -> Int
{
    let sum = x + y
    if x == y
    {
        return 3*sum
    }
    else
    {
        return sum
    }
}
sum2int(x: 1, y: 2)

//Ques 2
func absoluteDiff(n: Int) -> Int
{
    let diff = n - 51
    if n > 51
    {
        return 2*diff
    }
    else
    {
        return -diff
    }
}
absoluteDiff(n: 54)

//Ques 3
func isEqual20(x: Int, y: Int) -> Bool
{
    if x == 20 || y == 20 || x + y == 20 {
        return true
    }
    else
    {
        return false
    }
}
isEqual20(x: 20, y: 20)

//Ques 4
func isNegative(x: Int, y: Int) -> Bool
{
    if x >= 0 && y >= 0
    {
        return false
    }
    else
    {
        return true
    }
}
isNegative(x: -1, y: -1)
isNegative(x: 1, y: -1)
isNegative(x: -1, y: 1)
isNegative(x: 1, y: 1)

//ques 5
func addPrefixIs(str: String) -> String
{
    let newStr = str
    if newStr.hasPrefix("Is") || newStr.hasPrefix("is")
    {
        return newStr
    }
    else
    {
        return "Is" + newStr
    }
}

addPrefixIs(str: "Batman")
addPrefixIs(str: "IsBatman")

//ques 6
func removeChar(str: String, i: Int) -> String
{
    let count = str.count
    var newStr = str
    if i < count
    {
        newStr.remove(at: newStr.index(newStr.startIndex, offsetBy: i))
    }
    return newStr
}
removeChar(str: "Batman", i: 3)

//ques 7
func changeFirstAndLast(str: String) -> String
{
    var newStr = str
    let firstChar = newStr.remove(at: newStr.startIndex)
    let lastChar = newStr.remove(at: newStr.index(newStr.startIndex, offsetBy: newStr.count - 1))
    newStr.insert(lastChar, at: newStr.startIndex)
    newStr.append(firstChar)
    return newStr

}

changeFirstAndLast(str: "Batman")

//ques8
func addLastChar(str: String) ->String
{
    let count = str.count
    var newStr = str
    if count > 1 {
        let lastChar = newStr[newStr.index(before: newStr.endIndex)]
        newStr.insert(lastChar, at: newStr.startIndex)
        newStr.append(lastChar)
    }
    return newStr
}
addLastChar(str: "Batman")

//ques 9
func checkMultiple(x: Int)
{
    if x > 0 {
        if x%3 == 0 {
            print("\(x) is a mutiple of 3")
        }
        else if x%5 == 0
        {
            print("\(x) is a multiple of 5")
        }
        else
        {
            print("\(x), you have nothing, you lose, good day sir")
        }
    }
    else
    {
        print("\(x) not non-negative")
    }
}

checkMultiple(x: -1)
checkMultiple(x: 3)
checkMultiple(x: 4)
checkMultiple(x: 5)

//ques 26
func oddString(str: String) -> String
{
    let newStr = str
    var resultStr = ""
    var count = 0
    for index in newStr.indices {
        if count%2 == 0 {
            resultStr.append(newStr[index])
        }
        count += 1
    }
    return resultStr
}
oddString(str: "Batman")

//ques 27
func count77(arr: [Int]) -> Int
{
    var count = 0
    for (i, value)  in arr.enumerated() {
        //arr.startIndex
        //arr.endIndex
        if i > 0 && arr[i - 1] == value && value == 7 {
            count += 1
        }
    }
    return count
}

let arr: [Int] = [1,2,3,4,5,7,7]

count77(arr: arr)

//ques 24
func search(arr: [Int]) -> Bool
{
    var isExist = false
    for (i, value) in arr.enumerated() {
        if i > 1 && arr[i-1] == value - 1 && arr[i-2] == value - 2 {
            isExist = true
        }
    }
    return isExist
}

search(arr: [0,2,3,3,4,2,3,66,22,24423,234,243])

//ques 19
func changeSuffix(str: String) -> String
{
    if str.count < 3 {
        return str.lowercased()
    }
    else
    {
        var newStr = str
        let lastThree = newStr.suffix(3)
        //    for _ in 1...3 {
        //        newStr.removeLast()
        //    }
        newStr.removeLast(3)
        newStr.append(lastThree.uppercased())
        return newStr
    }
    
}

changeSuffix(str: "Batman and robin")

//ques 20
func firstAA(str: String) -> Bool
{
    var count = 0
    var isExist = false
    for index in str.indices {
        if count + 1 < str.count && str[index] == "a"
        {
            if str[index] == str[str.index(after: index)]
            {
                isExist = true
            }
            break
        }
        count += 1
    }
    return isExist
}

firstAA(str: "baatman")




