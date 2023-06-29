//
//  Transaction+Extension.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import Foundation
import CoreData

extension Transaction {
    @discardableResult convenience init(
        amount: Float,
        sfSymbol: String,
        title: String,
        context: NSManagedObjectContext = CoreDataStack.shared.mainContext)
    {
        
        self.init(context: context)
        
        self.amount = amount
        self.id = UUID()
        self.sfSymbol = sfSymbol
        self.timestamp = Date()
        self.title = title
    }
}
