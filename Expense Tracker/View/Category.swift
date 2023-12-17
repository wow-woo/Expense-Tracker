//
//  Category.swift
//  Expense Tracker
//
//  Created by woo on 12/17/23.
//

import SwiftUI

enum Category: String, CaseIterable{
    case income = "Income"
    case expense = "Expense"
}

#Preview {
    VStack{
        Text(Category.income.rawValue)
        Text(Category.expense.rawValue)
    }
}
