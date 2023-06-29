//
//  CreateTransactionSheet.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import SwiftUI

struct CreateTransactionSheet: View {
    @State var description: String = ""
    
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
            Text("Create a new Transaction")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 15)
                        
            TextField("Description", text: $description)
                .keyboardType(.default)
            
            TextField("Amount", value: $amount, formatter: formatter)
                .keyboardType(.numbersAndPunctuation)
            
            Spacer()
            
            Button {
                accountStore.newTransaction(account: account!, change: Float(amount), description: description)
                dismiss()
            } label: {
                Text("Create Transaction")
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
//    CreateTransactionSheet(
//        account: $account
//    ).environmentObject(AccountStore())
//}
