//
//  TransactionCardView.swift
//  Expense Tracker
//
//  Created by woo on 12/17/23.
//

import SwiftUI

struct TransactionCardView: View {
    var transaction: Transaction
    var body: some View {
        HStack(spacing: 12){
            Text("\(String(transaction.title.prefix(1)))")
                .font(.title)
                .fontWeight(.semibold)
                .frame(width:45, height: 45)
                .background(transaction.color.gradient, in:.circle)
            
            VStack(alignment: .leading, spacing:4) {
                Text(transaction.title)
                    .foregroundStyle(.primary)
                Text(transaction.remarks)
                    .font(.caption)
                    .foregroundStyle(.primary.secondary)
                Text(format(date: transaction.dateAdded, format: "dd MMM yyyy"))
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            .lineLimit(1)
            .hSpacing(.leading)
            
            Text(currencyString(transaction.amount, allowedDigits: 2))
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(.background, in: .rect(cornerRadius: 10))
    }
}

#Preview {
    let transaction01 = sampleTransactions[0]
    let transaction02 = sampleTransactions[1]
    return VStack (alignment:.leading){
        TransactionCardView(transaction: transaction01)
        TransactionCardView(transaction: transaction02)
    }
}
