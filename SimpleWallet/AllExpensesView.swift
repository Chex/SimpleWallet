//
//  AllExpensesView.swift
//  SimpleWallet
//
//  Created by Sean Chen on 5/25/24.
//

import SwiftUI

let initialExpenses: [Expense] = [
    Expense(amount: 50.0, type: .food, date: Date()),
    Expense(amount: 100.0, type: .housing, date: Date().addingTimeInterval(-172800)),
    Expense(amount: 20.0, type: .transportation, date: Date().addingTimeInterval(-86400)),
]

struct AllExpensesView: View {
    
    @StateObject private var expenseViewModel = ExpenseViewModel(expenses: initialExpenses)
    @State private var showingAddExpense = false
    
    private var navigationTitle: String {
#if SIMPLE_WALLET_A
        return "Wallet A"
#elseif SIMPLE_WALLET_B
        return "Wallet B"
#elseif SIMPLE_WALLET_C
        return "Wallet C"
#else
        return "All expenses"
#endif
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TypesChartView(expenses: expenseViewModel.expenses)
                        .padding()
                }
                ForEach(expenseViewModel.expenses) { expense in
                    
                    NavigationLink(destination: ExpenseView(expense: expense, onDelete: {
                        expenseViewModel.removeExpense(expense)
                    })) {
                        Text("\(expense.type.rawValue): $\(expense.amount, specifier: "%.2f")")
                    }
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddExpense = true
                    } label: {
                        Text("Add")
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView { newExpense in
                    expenseViewModel.addExpense(newExpense)
                    showingAddExpense = false
                }
            }
        }
    }
}
