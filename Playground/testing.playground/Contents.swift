import UIKit

//constant value
let mConst = 10

//variables
var mString = "batman"
var mString2: String = "robin"

print("I am " + mString)
print("I am " + mString2)

mString = mString + " and superman"

print("I am " + mString)

let minValue = UInt8.min
let maxValue = UInt8.max

//int to string
print("Max value is: " + String(maxValue))

let mThree = 3
let mElse = 0.94519

//int to double
let pi = Double(mThree) + mElse

//double to int: explicit
let intPi = Int(pi)

typealias AudioSample = UInt16
var maxExp = AudioSample.min

var amIAlive = true
var amIGay = false
if amIGay {
    print("u r gei")
}
else {
    print("u r not gei")
}
//Tuples example
var http404 = (404, "Not Found")

var statusCode: Int = 0
var statusMessage: String = ""
(statusCode, _) = http404
(statusCode, statusMessage) = http404

print("status code is \(statusCode)")
print("status code is \(http404.0)")
print("status msg is \(http404.1)")

let http200 = (statusCode: 200, description: "OK")

print("status msg is \(http200.statusCode)")

var mValue: Int?

mValue = nil

mValue = 999

if mValue != nil {
    print("mValue is not null, unwarp \(mValue!)")
}
else
{
    print("mValue is null")
}

var someOptional: Int?
//var constName: Int
someOptional = 100
if let constName = someOptional
{
    print(constName)
}
else
{
    print("nothing")
}

//Implicitly Unwrapped Optionals
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark

func sandwichMaker() throws
{
    
}

do {
    try sandwichMaker()
} catch {

}

let age = 3
//assert(age >= 0, "A person's age can't be less than zero.")
precondition(age > 0, "u r not a zombie")
if age > 10
{
    print("u can play")
}
else if age >= 0
{
    print("u r alive")
}
else
{
    assertionFailure("u r zombie")
}

