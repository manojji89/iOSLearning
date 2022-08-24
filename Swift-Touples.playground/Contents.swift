import UIKit

// Touple
//Tuples group multiple values into a single compound value. The values within a tuple can be of any type and don’t have to be of the same type as each other.

let httpError = (404, "No Internet")

let errorCode = httpError.0
let errorMessage = httpError.1

let (statusCode, statusMessage) = httpError
print("Status code is \(statusCode)")
print("Status message is \(statusMessage)")

let (justStatusCode, _) = httpError
print("Just status code is \(justStatusCode)")


let statusHttpError = (code: 404, message: "No Internet")
print("status code \(statusHttpError.code)")
print("status message \(statusHttpError.message)")
