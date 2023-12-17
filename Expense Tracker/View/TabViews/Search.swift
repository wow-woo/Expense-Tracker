//
//  Search.swift
//  Expense Tracker
//
//  Created by woo on 12/17/23.
//

import SwiftUI
import Combine

struct Search: View {
    @State private var searchText: String = ""
    @State private var filterText: String = ""
    let searchPublisher = PassthroughSubject<String, Never>()
    
    var body: some View {
        NavigationStack {
            ScrollView(){
                LazyVStack(spacing: 12){
                    
                }
            }
            .overlay{
                ContentUnavailableView(
                    "Search Transactions",
                    systemImage: "magnifyingglass"
                )
                .opacity(searchText.isEmpty ? 1 : 0)
            }
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    filterText = ""
                }
                searchPublisher.send(newValue)
            })
            .onReceive(
                searchPublisher.debounce(
                    for: .seconds(0.3), scheduler: DispatchQueue.main
                ),
                perform: { text in
                   filterText = text
            })
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .background(.gray.opacity(0.15))
        }
    }
}

#Preview {
    Search()
}
