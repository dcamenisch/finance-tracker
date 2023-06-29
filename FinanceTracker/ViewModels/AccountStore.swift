//
//  AccountStore.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import Foundation
import SwiftUI
import CoreData

class AccountStore: ObservableObject {
    @Published private(set) var accounts = [Account]()
    
    var totalBalance: String {
        var totalBalance: Float = 0
        
        for account in accounts {
            totalBalance += account.balance
        }
        
        return totalBalance.formattedBalance()
    }
    
    
    init() {
        getAccounts()
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
            getAccounts()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    // Create
    func addNewAccountWith(name: String, balance: Float, primaryColor: Color, secondaryColor: Color, completion: @escaping() -> Void) {
        _ = Account(name: name, balance: balance, primaryColor: primaryColor, secondaryColor: secondaryColor)
        saveToPersistentStore()
        completion()
    }
    
    // Read
    func getAccounts() {
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        do {
            accounts = try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
    
    // Update
    func update(account: Account, name: String, balance: Float) {
        account.name = name
        account.balance = balance
        saveToPersistentStore()
    }
    
    func updateBalance(account: Account, balance: Float) {
        let sfSymbol = balance - account.balance < 0 ? "minus.circle" : "plus.circle"
        let transaction = Transaction(amount: balance - account.balance, sfSymbol: sfSymbol, title: "Adjusted Balance")
        account.addToTransactions(transaction)
        
        update(account: account, name: account.name!, balance: balance)
        saveToPersistentStore()
    }
    
    func newTransaction(account: Account, change: Float, description: String) {
        let sfSymbol = change < 0 ? "minus.circle" : "plus.circle"
        let transaction = Transaction(amount: change, sfSymbol: sfSymbol, title: description)
        account.addToTransactions(transaction)
        
        update(account: account, name: account.name!, balance: account.balance + change)
        saveToPersistentStore()
    }
    
    // Delete
    func delete(account: Account) {
        let mainC = CoreDataStack.shared.mainContext
        mainC.delete(account)
        saveToPersistentStore()
    }
    
    func deleteAccount(at indexSet: IndexSet) {
        guard let index = Array(indexSet).first else { return }
        let account = self.accounts[index]
        delete(account: account)
    }
}
