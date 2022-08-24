import UIKit


var str = ""
var str1 = String()

var string1 = "My name is"
var string2 = " Manoj"
print(string1 + string2)

string1 += " Manoj"


for character in string2 {
    print(character)
}

// String Interpolation

/*String interpolation is a way to construct a new String value from a mix of constants, variables, literals, and expressions by including their values inside a string literal. You can use string interpolation in both single-line and multiline string literals. Each item that you insert into the string literal is wrapped in a pair of parentheses, prefixed by a backslash (\):
 */


let mutipier = 3
let message = "\(mutipier) time 2.5 is \(Double(mutipier) * 2.5)"



//Accessing and Modifying a String

//String Indices

var name = "manoj singhal"

print(name.startIndex)
print(name[name.startIndex])

print(name.endIndex)

print(name[name.index(after: name.startIndex)])
print(name[name.index(before: name.endIndex)])

// To print the index

for index in name.indices {
    print(index)
}


//Inserting and Removing

name.insert("a", at: name.endIndex)
print("name is \(name)")


name.remove(at: name.index(before: name.endIndex))
print("name is \(name)")
