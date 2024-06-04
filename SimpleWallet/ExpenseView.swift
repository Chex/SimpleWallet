//
//  ExpenseView.swift
//  SimpleWallet
//
//  Created by Sean Chen on 5/25/24.
//

import SwiftUI

struct ExpenseView: View {
    
    var expense: Expense
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("NZ$ \(expense.amount, specifier: "%.2f")")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            Text("\(expense.type.rawValue)")
                .font(.body)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            Text("\(expense.date, formatter: dateFormatter)")
                .font(.body)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: {
                onDelete()
            }) {
                Text("Delete")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(height: 44.0)
                    .frame(maxWidth: .infinity)
            }
            .tint(Color.red)
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
}
