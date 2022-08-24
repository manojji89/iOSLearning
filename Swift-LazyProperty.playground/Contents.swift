import UIKit

struct Employee {
    var name: String = ""
    lazy var department: String = ""
}

var employee = Employee()
debugPrint(employee)

employee.department = "Engineering"


struct ComplexTask {
    static var value: Int = 1
    static var result: Int = 0
    
    static func doComplexTask() -> Int {
        var task: [Int] = []
        
        for i in value...5000 {
            task.append(i)
        }
        
        result = task.first!
        return result
    }
}


struct Person {
    lazy var complexTask: Int = ComplexTask.doComplexTask()
}


var person = Person()
let result = person.complexTask
