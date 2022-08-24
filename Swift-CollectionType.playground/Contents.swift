import UIKit

// Array, Set, Dictionary

// Array - ordered collection of values
// Set - unordered collection of values
// Dictionary - unordered collection of key- value

/*
 Arrays

 An array stores values of the same type in an ordered list. The same value can appear in an array multiple times at different positions.


 */


var someInts: [Int] = []
someInts.append(4)
debugPrint(someInts)
//[4]

someInts = []
//[]

var counterArray = Array(repeating: 1, count: 4)
//[1, 1, 1, 1]



var shoppingList = [String]()
shoppingList.append("Buy Cloths")

print(shoppingList)
print("Shopping list count is \(shoppingList.count)")

if shoppingList.isEmpty {
    print("list is empty")
} else {
    print("list is not empty")
}

let firstItem = shoppingList[0]
let firstItem1 = shoppingList.first

shoppingList.insert("Buy Toys", at: 0)

//shoppingList.removeLast()


for (index, item) in shoppingList.enumerated() {
    print(item)
    print(index)
}

/*
 Sets

 A set stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items isn’t important, or when you need to ensure that an item only appears once.

 */

var set = Set<String>()
set.insert("Manoj")

set.insert("Taksh")

set.insert("Namish")

set.insert("Namu")

debugPrint(set)
//Set(["Manoj", "Namish", "Namu", "Taksh"])

set.insert("Manoj")

debugPrint(set)
//Set(["Manoj", "Namish", "Namu", "Taksh"])


var flowers: Set<String> = ["Rose", "SunFlower", "TigerLilli", "Lotus"]
print(flowers)

var fruits: Set = ["Apple", "Banana", "Orange", "Mango"]

if fruits.isEmpty {
    print("No fruits added")
} else {
    print("Fruits added")
}


for fruit in fruits {
    print(fruit)
}


let oddDigits: Set = [1, 3, 5, 7]
let evenDigits: Set = [2, 4, 6, 8]

let primeDigits: Set = [1,1,3,5,7]

oddDigits.intersection(primeDigits)
oddDigits.union(evenDigits)


/*
 Dictionaries

 A dictionary stores associations between keys of the same type and values of the same type in a collection with no defined ordering. Each value is associated with a unique key, which acts as an identifier for that value within the dictionary. Unlike items in an array, items in a dictionary don’t have a specified order. You use a dictionary when you need to look up values based on their identifier, in much the same way that a real-world dictionary is used to look up the definition for a particular word.
 */

var nameOfIngerger: [String: Int] = [:]
nameOfIngerger["sixteen"] = 16
nameOfIngerger["one"] = 1
nameOfIngerger["two"] = 3
nameOfIngerger["four"] = 4

print(nameOfIngerger)

print(nameOfIngerger["sixteen"])
