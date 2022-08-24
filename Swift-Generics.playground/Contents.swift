import UIKit
import Foundation

func swap<Element>(a: inout Element, b: inout Element) {
    let temp = a
    a = b
    b = temp
}

var a = 10
var b = 20

print("value of a \(a) and b \(b)")
swap(a: &a, b: &b)
print("swapped value of a \(a) and b \(b)")



struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}


var stack = Stack<Any>()
stack.push(7)
stack.push("Jorge")
let pop = stack.pop()



//func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable


// What is different between Any and Gernrics

func test1<T>(param1: T, param2: T) -> T {
    return param1
}

func test2(param1: Any, param2: Any) -> Any {
    return param1
}

func test3(param: Int) {
    
}

let output1 = test1(param1: 2, param2: 4)
let output2 = test2(param1: 2, param2: 4)

test3(param: output1)
/*
 test3(param: output2)
 error: Swift-Generics.playground:59:14: error: cannot convert value of type 'Any' to expected argument type 'Int'
 */

test3(param: output2 as! Int)
