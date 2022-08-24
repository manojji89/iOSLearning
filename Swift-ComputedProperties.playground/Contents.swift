import UIKit

// Example 1
struct LoanCalculator {
    var principal: Int
    var interestRate: Int
    var year: Int
    
    var interest: Int { // Computed Property
        get {
            return (principal * interestRate * year) / 100
        }
    }
    
}

let loanCalculator = LoanCalculator(principal: 1000, interestRate: 12, year: 5)
loanCalculator.interestRate



// Example 2
struct Circle {
    
    var radious: Double = 0.0
    var area: Double { // Computed Property
        get {
            return radious * radious * Double.pi
        }
    }
}

var circle = Circle()
circle.radious = 10.0
circle.area

