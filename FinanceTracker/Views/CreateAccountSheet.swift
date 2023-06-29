//
//  CreateAccountSheet.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import SwiftUI

struct CreateAccountSheet: View {
    @State var accountName: String = ""
    @State var primaryColor: Color = Color.random()
    @State var secondaryColor: Color = Color.random()

    @State private var amount = 0.0

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var accountStore: AccountStore
        
    var formatter: Formatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter
    }
    
    var body: some View {
        VStack {
            Text("Create a new Account")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 15)
                                    
            TextField("Account Name", text: $accountName)
                .keyboardType(.default)
            
            TextField("Initial Amount", value: $amount, formatter: formatter)
                .keyboardType(.decimalPad)
            
            ColorPicker(selection: $primaryColor) {
                Text("Primary Color")
            }
            
            ColorPicker(selection: $secondaryColor) {
                Text("Secondary Color")
            }
            
            Spacer()
            
            Button {
                accountStore.addNewAccountWith(name: accountName, balance: Float(amount), primaryColor: primaryColor, secondaryColor: secondaryColor) {
                    dismiss()
                }
            } label: {
                Text("Create Account")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
        }
        .padding()
    }
}

#Preview {
    CreateAccountSheet().environmentObject(AccountStore())
}
