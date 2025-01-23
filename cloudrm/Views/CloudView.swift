//
//  CloudView.swift
//  cloudrm
//
//  Created by Jean Laura on 13/01/25.
//

import SwiftUI

struct CloudView: View {
    
    @Binding var vm: CharacterViewModel
    @Binding var authvm: AuthViewModel
    
    @State private var isLoadingRefresh: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.charactersCloud.isEmpty {
                    ContentUnavailableView("Your cloud is empty", systemImage: "link.icloud")
                } else {
                    List {
                        
                        ForEach(vm.charactersCloud, id: \.id) { character in
                            RowCharacterCell(value: character, vm: $vm)
                                .swipeActions {
                                    Button {
                                        Task {
                                            await vm.deleteCharacterCloud(value: character)
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                }
                        }
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        authvm.signOut()
                    } label: {
                        
                        Image(systemName: "lock.icloud.fill")
                            .foregroundStyle(.orange)
                        
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(authvm.userCloud?.email ?? "No email")
                        .font(.system(size: 14, design: .monospaced))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            isLoadingRefresh.toggle()
                            await vm.getAllCharacterCloud()
                            isLoadingRefresh.toggle()
                        }
                    } label: {
                        if isLoadingRefresh {
                            ProgressView()
                        } else {
                            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.icloud")
                        }
                        
                    }
                }
            }
            .navigationTitle("Cloud")
            .navigationDestination(for: Character.self) { obj in
                CharacterViewDetails(manager: $vm, character: obj)
            }
        }
    }
}

#Preview {
    CloudView(vm: .constant(CharacterViewModel()),
              authvm: .constant(AuthViewModel()))
}
