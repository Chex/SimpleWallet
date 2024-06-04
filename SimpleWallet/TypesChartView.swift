//
//  TypesChartView.swift
//  SimpleWallet
//
//  Created by Sean Chen on 5/25/24.
//

import SwiftUI
import Charts

struct TypesChartView: View {
    
    var expenses: [Expense]
    
    var body: some View {
        
        let groupedExpenses = Dictionary(grouping: expenses, by: { $0.type })
        var data = groupedExpenses.map { (type, expenses) in
            (type: type.rawValue, total: expenses.reduce(0) { $0 + $1.amount })
        }
        data.sort { $0.type < $1.type }
        let totalAmount = expenses.reduce(0) { $0 + $1.amount }
        
        return Chart(data, id: \.type) { element in
            SectorMark(
                angle: .value("Amout", element.total),
                innerRadius: .ratio(0.618),
                angularInset: 1.5
            )
            .cornerRadius(5.0)
            .foregroundStyle(by: .value("Name", element.type))
        }
        .chartLegend(alignment: .center, spacing: 18)
        .scaledToFit()
        
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                let frame = geometry[chartProxy.plotFrame!]
                VStack {
                    Text("NZ$ \(totalAmount, specifier: "%.2f")")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                }
                .position(x: frame.midX, y: frame.midY)
            }
        }
    }
}
