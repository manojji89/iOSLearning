import UIKit

// Closures
// What are Closures
// When to use Closures
// How to use Closures


func addToNumbers(number1: Int, number2: Int) -> Int {
    return number1 + number2
}

let result = addToNumbers(number1: 10, number2: 20)


var additionOfTwoNumber :(Int, Int) -> Int = {
    number1, number2 in
    return number1 + number2
}

additionOfTwoNumber(2, 3)
