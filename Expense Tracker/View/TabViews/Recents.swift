//
//  Recents.swift
//  Expense Tracker
//
//  Created by woo on 12/17/23.
//

import SwiftUI

struct Recents: View {
    @AppStorage("userName")
    var userName: String = ""
    @State
    private var startDate: Date = .now.startOfMonth
    @State
    private var endDate: Date = .now.endOfMonth
    @State
    private var selectedCategory: Category = .expense
    @State
    private var showFilterView: Bool = false
    @Namespace private var animation
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            NavigationStack {
                ScrollView(.vertical){
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            Button(action: {
                                showFilterView = true
                            }, label: {
                                Text("\(format(date: startDate,format: "dd MMM yy")) to \(format(date: endDate,format:"dd MMM yy"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            })
                            .hSpacing(.leading)
                            
                            CardView(income: 2039, expense: 4098)
                            
                            CustomSegmentControl()
                            
                            ForEach(sampleTransactions.filter({
                                $0.category == selectedCategory.rawValue
                            })){ transaction in
                               TransactionCardView(transaction: transaction)
                            }
                            .onDelete(perform: { indexSet in
//                                for idx in indexSet {
//                                    
//                                }
                            })
                        } header: {
                           HeaderView(size)
                        }
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showFilterView ? 3.5 : 0)
                .disabled(showFilterView)
            }
            .overlay {
                ZStack{
                    if showFilterView {
                        DateFilterView(
                            start: startDate,
                            end: endDate,
                            onSubmit: { start, end in
                                startDate = start
                                endDate = end
                                showFilterView = false
                            },
                            onClose: {
                                showFilterView = false
                            }
                        )
                        .transition(.move(edge: .leading))
                    }
                }
                .animation(.snappy, value: showFilterView)
            }
        }
    }
    
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        HStack (spacing: 10){
            VStack(alignment: .leading, spacing:  5){
                Text("Welcome!")
                .font(.title.bold())
                
                if !userName.isEmpty {
                    Text(userName)
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            }
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(
                        headerScale(size, proxy: geometryProxy),
                        anchor: .topLeading
                    )
            }
            
            Spacer(minLength: 0)
            
            NavigationLink {
                
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width:45, height: 45)
                    .background(appTint.gradient, in: .circle)
                    .contentShape(.circle)
            }
            
        }
        .padding(.bottom, userName.isEmpty ? 10:5)
        .background{
            VStack(spacing: 0){
                Rectangle()
                    .fill(.ultraThinMaterial)
                Divider()
            }
            .visualEffect { content, geometryProxy in
                content
            }
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
    }
    
    @ViewBuilder
    func CustomSegmentControl() -> some View {
        HStack(){
            ForEach(Category.allCases, id:\.rawValue){ category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical, 10)
                    .background {
                        if selectedCategory  == category {
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy){
                            selectedCategory = category
                        }
                    }
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
    }
    
    func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : (-minY / 15)
    }
    
    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        
        let progress = minY / screenHeight
        let scale = (min(max(progress, 0), 1)) * 0.3
        return 1 + scale
    }
}

#Preview {
    Recents()
}
