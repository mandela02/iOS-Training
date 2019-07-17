import UIKit

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var threeItems = FixedLengthRange(firstValue: 3, length: 3)
threeItems.firstValue = 6

var fourItems = FixedLengthRange(firstValue: 0, length: 4)

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.1, y: 0.1), size: Size(width: 10.0, height: 10.0))
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
square.center = Point(x: 3, y: 3)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")



