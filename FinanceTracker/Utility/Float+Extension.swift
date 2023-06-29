//
//  Float+Extension.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import Foundation

extension Float {
    func formattedBalance() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        let formattedString: String = formatter.string(for: self)!
        return formattedString
    }
}
