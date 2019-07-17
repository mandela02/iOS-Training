import UIKit

class Media
{
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: Media
{
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: Media
{
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
Movie(name: "Justice League", director: "Zack Snyder"),
Song(name: "Never Gonna Gice You Up", artist: "Rick Roll"),
Movie(name: "Power Rangers", director: "ME")
]

var movieCount = 0
var songCount = 0


for item in library {
    if item is Movie
    {
        movieCount += 1
    }
    if item is Song
    {
        songCount += 1
    }
}

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

var things = [Any]()
things.append(0)
things.append(0.0)
things.append("asdasdasd")
things.append((3.0,3.0))
things.append(Movie(name: "Man of Steel", director: "Zack Snyder"))
things.append({(name: String)->String in "Hello \(name)"})

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.0.ft
print("Three feet is \(threeFeet) meters")

protocol FullyNamed {
    var fullName: String { get }
}


class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String) {
        self.name = name
        self.prefix = prefix
    }
        var fullName: String
        {
            return (prefix != nil ? prefix! + " " : "") + name
        }
        
    }

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

struct Stack<Element>
{

}

