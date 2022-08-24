import Foundation

let json = """
{
  "name" : "John",
  "email"  "john@xyz.com"
}
"""
print(json)

let jsonData = """
{
  "name": "John",
  "email"  "john@xyz.com"
}
""".data(using: .utf8)!

print(jsonData)

struct Employee {
    let name: String
    let email: String
}

struct CodableEmployee: Codable {
    let name: String
    let email: String
}


struct EncodableEmployee: Encodable {
    let name: String
    let email: String
}


struct DecodableEmployee: Decodable {
    let name: String
    let email: String
}

let employeeModel = try JSONDecoder().decode(CodableEmployee.self, from: jsonData)
print(employeeModel)

/*
 let encodableModel = try JSONDecoder().decode(EncodableEmployee.self, from: jsonData)
 print(encodableModel)
 
 Instance method 'decode(_:from:)' requires that 'EncodableEmployee' conform to 'Decodable'
 */

let decodableModel = try JSONDecoder().decode(DecodableEmployee.self, from: jsonData)
print(decodableModel)

do {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
    let data = try encoder.encode(employeeModel)
    if let jsonString = String(data: data, encoding: .utf8)
    {
        print(jsonString)
    }
} catch {
    print(error)
}



let productJsonData = """
{
  "name": "Macbook",
  "price": 50000,
  "product_id": "1234",
}
""".data(using: .utf8)!
print(jsonData)


struct Product: Decodable {
    let name: String
    let price: Int
    let productId: String
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case name = "name"
        case price = "price"
    }
}

let productModel = try JSONDecoder().decode(Product.self, from: productJsonData)
print(productModel)



struct Student: Codable {
    let studentName: String
}

let studentModel = Student(studentName: "Manoj Singhal")


// Now Encode a model to get the JSON then will use JSON to create the model again

var encodededStudentData = Data()
do {
    let data = try JSONEncoder().encode(studentModel)
    encodededStudentData = data
    let jsonString = String(data: data, encoding: .utf8)
    print("Student JSON \(String(describing: jsonString))")
} catch {
    print(error)
}


let decodedStudentModel = try JSONDecoder().decode(Student.self, from: encodededStudentData)

