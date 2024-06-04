//
//  AddExpenseView.swift
//  SimpleWallet
//
//  Created by Sean Chen on 5/25/24.
//

import SwiftUI

struct AddExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var amount: String = ""
    @State private var selectedType: ExpenseType = .others
    @State private var showingAlert = false
    
    var onSave: (Expense) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                Picker("Type", selection: $selectedType) {
                    ForEach(ExpenseType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if let amount = Double(amount) {
                            let newExpense = Expense(amount: amount, type: selectedType, date: Date())
                            onSave(newExpense)
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            showingAlert = true
                        }
                    } label: {
                        Text("Save")
                    }
                }
            }
            .navigationTitle("Add an expnse")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Invalid amount"),
                      message: Text("Please enter a valid amount."))
            }
        }
    }
}
