import UIKit

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by: backward)

reversedNames = names.sorted(by: {(s1: String, s2: String) -> Bool in
        return s1 > s2
})

reversedNames = names.sorted(by: {s1, s2 in return s1 > s2})
reversedNames = names.sorted(by: <)

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

//let strings = numbers.map { (number) -> String in
//    var number = number
//    var output = ""
//    repeat {
//        output = digitNames[number % 10]! + output
//        number /= 10
//    } while number > 0
//    return output
//}

var strings = [String]()

for item in numbers {
    var num = item
    var output = ""
    while num > 0 {
        output = digitNames[num % 10]! + output
        num /= 10
    }
    strings.append(output)
}

for item in strings {
    print(item)
}

enum CompassPoint {
    case north
    case south
    case east
    case west
}
var directionToHead = CompassPoint.east
directionToHead = .west

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ASDFGHJKLJHGJHGJHGJKHJGJHJJHGH")
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

