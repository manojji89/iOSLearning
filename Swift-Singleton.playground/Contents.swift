import UIKit

//let urlSessionShared = URLSession.shared

//let fileManager = FileManager.default

//let userDefault = UserDefaults.standard


class LocationManager {
    
    static let shared = LocationManager()
    
    private init() {}
    
    func getlocation() {
        print("your location")
    }
    
}

//let locationManager = LocationManager()
//'LocationManager' initializer is inaccessible due to 'private' protection level

let locationManagerShared = LocationManager.shared.getlocation()


class NetworkManager {
    
    static let shared = NetworkManager(url: URL(string: "www.google.com")!)
    
    let url: URL
    
    private init(url: URL) {
        self.url = url
    }
}


let url = NetworkManager.shared.url
print(url)
