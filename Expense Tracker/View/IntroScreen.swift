//
//  IntroScreen.swift
//  Expense Tracker
//
//  Created by woo on 12/17/23.
//

import SwiftUI

struct IntroScreen: View {
    @AppStorage("isFirstTIme")
    private var isFirstTime: Bool = true
    
    var body: some View {
        VStack(spacing:15){
            Text("What's New in the\nExpense Tracker")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 65)
                .padding(.bottom, 35)
            
            VStack(alignment: .leading, spacing: 25, content: {
                PointView(symbol: "dollarsign", title: "Transactions", subTitle: "Keep track of your earnings and expense")
                PointView(symbol: "chart.bar.fill", title: "Visual Charts", subTitle: "View your transaction using eye-catching raphic representations")
                PointView(symbol: "magnifyingglass", title: "Advanced Filters", subTitle: "Find the expenses you want by advanced search and filtering")
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            
            Spacer(minLength: 10)
            
            Button(action: {
                isFirstTime = false
            }, label: {
                Text("Continue")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(appTint.gradient, in: .rect(cornerRadius: 12))
                    .contentShape(.rect)
            })
        }
    }
    
    @ViewBuilder
    func PointView(symbol: String, title: String, subTitle: String)-> some View {
        HStack(spacing: 15){
           Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(appTint.gradient)
                .frame(width: 45)
            
            VStack(alignment: .leading, spacing:  6, content: {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(subTitle)
                    .foregroundStyle(.gray)
            })
        }
    }
}

#Preview {
    IntroScreen()
}
