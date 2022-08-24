import UIKit

class Bank {
    
    var accountBalance: Int {
        didSet {
            sendMessage()
        }
        
        willSet(newBalance) {
            if newBalance >= 100000 {
                sendMessageToAuditor()
            }
        }
        
    }
    
    init(openingBalance: Int) {
        self.accountBalance = openingBalance
    }
    
    func addMoney(amount: Int) {
        accountBalance += amount
        // sendMessage()
    }
    
    func withdrawMoney(amount: Int) {
        accountBalance -= amount
        // sendMessage()
    }
    
    func sendMessage() {
        print("Your account has new balance \(accountBalance)")
    }
    
    func sendMessageToAuditor() {
        print("Please check if transaction is authentic")
    }
}


let bank = Bank(openingBalance: 1000)

//bank.addMoney(amount: 500)

//bank.withdrawMoney(amount: 100)

bank.addMoney(amount: 200000)
