//
//  AdjustBalanceSheet.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import SwiftUI

struct AdjustBalanceSheet: View {
    @State private var amount = 0.0
    
    @Binding var account: Account?
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var accountStore: AccountStore
    
    var formatter: Formatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter
    }
    
    var body: some View {
        VStack {
            Text("Adjust Account Balance")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 15)
                        
            TextField("New Balance", value: $amount, formatter: formatter)
                .keyboardType(.decimalPad)

            Spacer()
            
            Button {
                accountStore.updateBalance(account: account!, balance: Float(amount))
                dismiss()
            } label: {
                Text("Adjust Balance")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
        }
        .padding()
    }
}

//#Preview {
//    @State var account = Account(
//        name: "Test",
//        balance: 0.0,
//        primaryColor: .blue,
//        secondaryColor: .red
//    )
//    
//    AdjustBalanceSheet(
//        account: $account
//    ).environmentObject(AccountStore())
//}
