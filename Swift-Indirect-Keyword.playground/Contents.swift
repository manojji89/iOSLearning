import UIKit

/*
enum example {
    case something( Int, example)
}
 */

/*
 expression failed to parse:
 error: Swift-Indirect-Keyword.playground:4:6: error: recursive enum 'example' is not marked 'indirect'
 enum example {
      ^
 indirect

 Swift-Indirect-Keyword.playground:5:10: note: cycle beginning here: (Int, example) -> (.1: example)
     case something( Int, example)
          ^

 */

enum example {
  indirect case something(Int, example)
}
