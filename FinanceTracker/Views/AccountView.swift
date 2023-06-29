//
//  AccountView.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import SwiftUI

struct AccountView: View {
    @State var isPresented: Bool = false
    @State var isDraged: Bool = false
    
    @State var account: Account
    
    @EnvironmentObject var accountStore: AccountStore
    
    var body: some View {
        VStack {
            HStack {
                BankCard(isPresented: $isPresented, isDraged: $isDraged, account: account)
                    .gesture(DragGesture()
                        .onChanged { value in
                            if value.translation.width <= -25 {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.5)) {
                                    self.isDraged = true
                                    self.isPresented = false
                                }
                            }
                            
                            if value.translation.width >= 25 {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.5)) {
                                    self.isDraged = false
                                }
                            }
                        }
                    )
                
                if isDraged {
                    Button {
                        withAnimation { accountStore.delete(account: account) }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                            .shadow(radius: 10, x: 10, y: 10)
                    }
                    .offset(x: -20)
                }
            }
            
            if isPresented {
                ZStack {
                    Color(.transactionBackground)
                    VStack (spacing: 25){
                        Text("Transactions")
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                        
                        ForEach(Array(account.transactions! as! Set<Transaction>).sorted(by: {
                            $0.timestamp!.compare($1.timestamp!) == .orderedDescending
                        }), id: \.self) { transaction in
                            Expense(transaction: transaction)
                        }
                    }.padding(.vertical, 20)
                }
                .cornerRadius(25.0)
                .shadow(radius: 10, x: 10, y: 10)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .transition(AnyTransition.opacity.combined(with: .offset(y: 400)))
            }
            
            Spacer().layoutPriority(1)
        }
    }
}

struct BankCard: View {
    @Binding var isPresented: Bool
    @Binding var isDraged: Bool
    
    @State var account: Account
    
    var body: some View {
        ZStack {
            LinearGradient(gradient:
                            Gradient(colors: [
                                Color(UIColor(hex: account.primaryColor!)!),
                                Color(UIColor(hex: account.secondaryColor!)!)
                            ]),
                           startPoint: .bottomLeading,
                           endPoint: .topTrailing
            )
            
            VStack {
                Text(account.name ?? "")
                    .foregroundColor(.white)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer(minLength: 0)
                
                Text(account.balance.formattedBalance())
                    .foregroundColor(.white)
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .frame(height: isPresented ? 225 : 100)
        }
        .onTapGesture {
            withAnimation {
                isDraged = false
                isPresented.toggle()
            }
        }
        .cornerRadius(25.0)
        .shadow(radius: 10, x: 10, y: 10)
        .padding(.horizontal, 20)
    }
}

struct Expense: View {
    var transaction: Transaction
    
    var body: some View {
        HStack {
            Image(systemName: transaction.sfSymbol!)
                .font(.system(size: 25, weight: .bold, design: .rounded))
            
            Text(transaction.title ?? "").font(.system(size: 20, weight: .bold, design: .rounded))
            
            Spacer()
            
            Text(transaction.amount.formattedBalance())
                .font(.system(size: 20, weight: .medium, design: .rounded))
        }
        .shadow(radius: 6, x: 5, y: 5)
        .foregroundColor(.white)
        .padding(.horizontal, 20)
    }
}

#Preview {
    AccountView(
        account: Account(
            name: "Test",
            balance: 0.0,
            primaryColor: .blue,
            secondaryColor: .red
        )
    )
}
