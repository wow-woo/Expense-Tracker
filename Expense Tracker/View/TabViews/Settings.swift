//
//  Settings.swift
//  Expense Tracker
//
//  Created by woo on 12/17/23.
//

import SwiftUI

struct Settings: View {
    @AppStorage("userName")
    private var userName: String = ""
    @AppStorage("isAppLockEnalbled")
    private var isAppLockEnalbed: Bool = true
    @AppStorage("lockWhenAppGoesBackground")
    private var lockWhenAppGoesBackground: Bool = true
    
    var body: some View {
        NavigationStack {
            List {
                Section("User Name"){
                    TextField("your name", text: $userName)
                }
                
                Section("App Lock"){
                    Toggle("Enable App Lock", isOn: $isAppLockEnalbed)
                    
                    Toggle(
                        "Lock When AppGoesBackGround",
                        isOn: $lockWhenAppGoesBackground
                    )
                    .disabled(!isAppLockEnalbed)
                    .foregroundStyle(isAppLockEnalbed ? .black : .gray)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    Settings()
}
