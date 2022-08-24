import UIKit

protocol Shape {
    func area()-> Double
}

struct Rectangle: Shape {
    let width: Double
    let length: Double
    
    func area() -> Double {
        width * length
    }
}

struct Square: Shape {
    let side: Double
    func area() -> Double {
        side * side
    }
}

let rectangle = Rectangle(width: 10.0, length: 10.0)
let area1 = rectangle.area()

let square = Square(side: 10)
let area2 = square.area()
