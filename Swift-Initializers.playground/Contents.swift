import UIKit

/*
 init() {
 
 }
 */

// Custom initializer
enum Gender {
    case male
    case female
    case unknown
}

class Human {
    let age: Int
    let gender: Gender
    
    init(age: Int) {
        self.age = age
        self.gender = .unknown
    }
    
    init(age: Int, gender: Gender) {
        self.age = age
        self.gender = gender
    }
}

let human1 = Human(age: 30)
let human2 = Human(age: 40, gender: .male)


// Default Initailizer
class Employee {
    var name: String?
    var isDeveloper = false
}
let employee = Employee()

// Example for Struct
struct Size {
    var width: Double
    var height: Double
    
    init() {
        self.width = 20.0
        self.height = 20.0
    }
}

//let size1 = Size(width: 20.0, height: 30.0)
let size2 = Size()

// Designated, Convenience, Failable

/*
 Designated initializers
 Convenience initializers
 
 Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.
 Every class should have at least one designated initializer.
 
 Designated initializers for classes are written in the same way as simple initializers for value types:
 
 */

class HumanBeing {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let humanbeing = HumanBeing(name: "Jorge")

class HumanBeing1 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "No Name")
    }
}

let humanbeing1 = HumanBeing1() // Convenience Intialiser
let humanbeing2 = HumanBeing1(name: "Jorge") // Designated Initialiser

// Failable Initialiser

//init?()

class ShapeClass {
    var width: Double
    var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

let shapeClass = ShapeClass(width: 30, height: 40)

enum ShapeType {
    case circle
    case square
}

class Shape1 {
    var shapeType: ShapeType
    
    init?(type: ShapeType) {
        if type == .circle {
            return nil
        }
        self.shapeType = type
    }
}

let shapeTypeObj = Shape1(type: .circle)


// Required Initializer

class A {
    required init() {
        let a = 10
        print(a)
    }
}

class B : A {
    required init() {
        let b = 20
        print(b)
    }
}

let objA = A()

let objB = B()


class C: A {
    
}

let objC = C()
