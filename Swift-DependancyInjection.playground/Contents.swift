import UIKit
import Foundation

struct User {
    let name: String
    let email: String
}

class LoginAPI {
    
    // function to call the API and get the Data
    func makeAPICall() -> Data {
        return Data()
    }
}

class LoginViewModel {
    let api: LoginAPI = LoginAPI()
    
    func authenticateUser(user: User)  {
        api.makeAPICall()
    }
}

let viewModel = LoginViewModel()
viewModel.authenticateUser(user: User(name: "Manoj", email: "manoj.singhal1989@gmail.com"))


// We can apply Dependeny Injection here
// 1. Property Injection
// 2. Constructor Injection


class LoginViewModelUsingPropertyInjection {
    var api: LoginAPI?
    init() {
        
    }
    
    func authenticateUser(user: User)  {
        if let loginApi = api {
            loginApi.makeAPICall()
        }
    }
}


let viewModel1 = LoginViewModelUsingPropertyInjection()
viewModel1.api = LoginAPI()
viewModel1.authenticateUser(user: User(name: "Manoj", email: "manoj.singhal1989@gmail.com"))

class LoginViewModelUsingConsructorInjection {
    var api: LoginAPI
    
    init(loginAPI: LoginAPI) {
        self.api = loginAPI
    }
    
    func authenticateUser(user: User)  {
        api.makeAPICall()
    }

}

let loginAPI = LoginAPI()
let viewModel2 = LoginViewModelUsingConsructorInjection(loginAPI: loginAPI)
viewModel2.authenticateUser(user: User(name: "Manoj", email: "Singhal"))
