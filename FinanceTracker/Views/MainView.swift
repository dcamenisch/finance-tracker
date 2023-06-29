//
//  MainView.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var accountStore: AccountStore
    
    @State var isPresentedCreateAccount = false
    @State var isPresentedNewTransaction = false
    @State var isPresentedUpdateBalance = false
    @State var selectedAccount: Account?
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Total Balance:")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                    
                    Spacer()
                    
                    Text("\t\(accountStore.totalBalance)")
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                }
                .padding(.horizontal, 25)
                .padding(.top, 15)
                
                ScrollView {
                    ForEach(accountStore.accounts) { account in
                        AccountView(account: account)
                            .contextMenu {
                                Button {
                                    selectedAccount = account
                                    isPresentedNewTransaction.toggle()
                                } label: {
                                    Label("New Transaction", systemImage: "plus")
                                }
                                
                                Button {
                                    selectedAccount = account
                                    isPresentedUpdateBalance.toggle()
                                } label: {
                                    Label("Update Balance", systemImage: "arrow.clockwise")
                                }
                                
                                Button {
                                    accountStore.delete(account: account)
                                } label: {
                                    Label("Remove Account", systemImage: "trash")
                                }
                            }
                    }
                }
            }
            
            Button {
                isPresentedCreateAccount.toggle()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 40))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.horizontal, 25)
        }
        .sheet(isPresented: $isPresentedCreateAccount, content: {
            CreateAccountSheet()
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
        })
        .sheet(isPresented: $isPresentedNewTransaction, content: {
            CreateTransactionSheet(account: $selectedAccount)
                .presentationDetents([.fraction(0.3)])
                .presentationDragIndicator(.visible)
        })
        .sheet(isPresented: $isPresentedUpdateBalance, content: {
            AdjustBalanceSheet(account: $selectedAccount)
                .presentationDetents([.fraction(0.3)])
                .presentationDragIndicator(.visible)
        })
    }
}


#Preview {
    MainView().environmentObject(AccountStore())
}
