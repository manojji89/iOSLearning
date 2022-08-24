import UIKit

// Range Operators

//1. Closed Range Operator

for index in 1...5 {
    print(index)
}
/*
 1
 2
 3
 4
 5
 */

//2. Half-Open Range Operator => it will not include the final value

for index in 1..<5 {
    print(index)
}

/*
 1
 2
 3
 4
 */

//3. One-Sided Ranges

let names = ["Anna", "Alex", "Brian", "Jack"]

for name in names[...2] {
    print(name)
}

/*
Anna
Alex
Brian
*/

for name in names[2...] {
    print(name)
}
/*
 Brian
 Jack
 */
