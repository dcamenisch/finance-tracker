//
//  Account+Extension.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import Foundation
import CoreData
import SwiftUI

extension Account {
    @discardableResult convenience init(
        id: UUID = UUID(),
        name: String,
        balance: Float,
        primaryColor: Color,
        secondaryColor: Color,
        context: NSManagedObjectContext = CoreDataStack.shared.mainContext)
    {
        
        self.init(context: context)
        
        self.balance = balance
        self.id = id
        self.name = name
        self.primaryColor = UIColor(primaryColor).asHex
        self.secondaryColor = UIColor(secondaryColor).asHex
        
        self.transactions = [Transaction(amount: balance, sfSymbol: "dollarsign.circle", title: "Initial Deposit")]
    }
}
