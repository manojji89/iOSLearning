import UIKit

class Tax {
    var gst: Double
    init(gst: Double) {
        self.gst = gst
    }
}

struct Item {
    var totalPrice: Double
    var tax: Tax
}

let item1 = Item(totalPrice: 100.0, tax: Tax(gst: 40.0))
var item2 = item1

item2.totalPrice = 105
item2.tax.gst = 15.0

print(item2.tax.gst)
print(item1.tax.gst)

print(item2.totalPrice)
print(item1.totalPrice)


struct A {
    var x: Int = 4
    mutating func changeValue(dict: [String: Int]) {
        self.x = dict["xvalue"]!
    }
}

class B {
    var y: Int = 4
    func changeValue(dict: [String: Int]) {
        self.y = dict["xvalue"]!
    }
}

actor C {
    var y: Int = 4
    func changeValue(dict: [String: Int]) {
        self.y = dict["xvalue"]!
    }
}


