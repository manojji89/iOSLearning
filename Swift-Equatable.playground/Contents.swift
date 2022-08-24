import UIKit

//Identity Operator
class Phone: Equatable {
    static func == (lhs: Phone, rhs: Phone) -> Bool {
       return lhs.udid == rhs.udid
    }
    var udid: String
    init(udid: String) {
        self.udid = udid
    }
}

let phone1 = Phone(udid: "ABCDEFGH")
let phone2 = Phone(udid: "ABCDEFGH")

print(phone1 == phone2 ? "equal" : "not equal")
print(phone1 === phone2 ? "identical" : "not identical")
