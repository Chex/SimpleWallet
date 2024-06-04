//
//  Expense.swift
//  SimpleWallet
//
//  Created by Sean Chen on 5/25/24.
//

import Foundation

enum ExpenseType: String, CaseIterable, Identifiable {
    case food = "Food"
    case transportation = "Transportation"
    case housing = "Housing"
    case others = "Others"
    
    var id: String { self.rawValue }
}

struct Expense: Identifiable {
    var id = UUID()
    var amount: Double
    var type: ExpenseType
    var date: Date
}

class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense]
    
    init(expenses: [Expense] = []) {
        self.expenses = expenses
    }
    
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
    }
    
    func removeExpense(_ expense: Expense) {
        if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
            expenses.remove(at: index)
        }
    }
}
