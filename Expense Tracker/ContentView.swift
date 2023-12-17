//
//  ContentView.swift
//  Expense Tracker
//
//  Created by woo on 12/17/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFirstTIme")
    private var isFirstTime: Bool = true
    @State
    private var activaTab: Tab = .recents
    
    var body: some View {
        TabView(selection: $activaTab){
            Recents()
            .tag(Tab.recents)
            .tabItem { Tab.recents.tabContent }
            
            Search()
            .tag(Tab.search)
            .tabItem { Tab.search.tabContent }
            
            Graphs()
            .tag(Tab.charts)
            .tabItem { Tab.charts.tabContent }
            
            Settings()
            .tag(Tab.settings)
            .tabItem { Tab.settings.tabContent }
        }
        .tint(appTint)
        .sheet(isPresented: $isFirstTime, content: {
            IntroScreen()
//                .interactiveDismissDisabled()
        })
    }
}

#Preview {
    ContentView()
}
