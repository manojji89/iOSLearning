import UIKit

/*
 Associated types are a powerful way of making protocols generic, but they can be a bit confusing at first. In essence, they mark holes in protocols that must be filled by whatever types conform to those protocols.
 
 Let’s start with a simple example: an ItemStoring protocol that can store items in an array. What type those items are depends on whatever conforms to the protocol, but we can still use them inside the protocol and any extensions.
 
 */

protocol ItemSorting {
    associatedtype DataType
    var items: [DataType] {get set}
    mutating func add(item: DataType)
}

extension ItemSorting {
    mutating func add(item: DataType) {
        items.append(item)
    }
}


struct NameDataBase: ItemSorting {
    var items = [String]()
}

var object = NameDataBase()
object.add(item: "Test")
print(object)

protocol Stack {
    associatedtype Element
    func push(item: Element)
    func pop() -> Element
}

class StackImp: Stack {
    
    typealias Element = Int
    var array = [Int]()
    
    func push(item: Int) {
        array.append(item)
    }
    
    func pop() -> Int {
        array.removeLast()
    }
}

protocol MyProAssociate {
    associatedtype MyType
    func sumOf(x: MyType, y: MyType) -> MyType
}

class MyCls1: MyProAssociate {
    
    typealias MyType = Int
    func sumOf(x: Int, y: Int) -> Int {
        return x + y
    }
}

class MyCls2: MyProAssociate {
    
    typealias MyType = Float
    func sumOf(x: Float, y: Float) -> Float {
        return x + y
    }
}
