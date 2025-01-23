//
//  MainAppView.swift
//  cloudrm
//
//  Created by Jean Laura on 12/01/25.
//

import SwiftUI

struct MainAppView: View {
    
    @State var characterDelegate: CharacterViewModel = CharacterViewModel()
    @State var authDelegate: AuthViewModel = AuthViewModel()

    var body: some View {
        
        
        TabView {
            
            Tab("Network", systemImage: "personalhotspot") {
                NetView(vm: $characterDelegate)
            }
            
            Tab("Storage", systemImage: "externaldrive") {
                LocalView(vm: $characterDelegate)
            }
            
            Tab("Cloud", systemImage: "cloud") {
                if authDelegate.userCloud != nil {
                    CloudView(vm: $characterDelegate, authvm: $authDelegate)

                } else {
                    LoginView(authvm: $authDelegate)
                }
            }
            
            Tab("Search", systemImage: "magnifyingglass") {
                SearchView(vm: $characterDelegate)
            }
                
            
        }
        .tint(.indigo)
        .environment(\.authViewModel, authDelegate)
        
    }
}

#Preview {
    MainAppView()
}
