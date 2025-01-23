//
//  LocalView.swift
//  cloudrm
//
//  Created by Jean Laura on 12/01/25.
//

import SwiftUI

struct LocalView: View {
    
    @Binding var vm: CharacterViewModel
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.charactersDisk.isEmpty {
                    ContentUnavailableView("Your disk is empty", systemImage: "externaldrive.badge.xmark")
                } else {
                    List {
                        
                        ForEach(vm.charactersDisk, id: \.id) { character in
                            RowCharacterCell(value: character, vm: $vm)
                                .swipeActions {
                                    Button {
                                        vm.deleterCharacterDisk(value: character)
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        vm.getAllCharacterDisk()
                    } label: {
                        Image(systemName: "arrow.trianglehead.2.counterclockwise")
                    }
                }
            }
            .navigationTitle("Local")
            .navigationDestination(for: Character.self) { obj in
                CharacterViewDetails(manager: $vm, character: obj)
            }
            
        }
    }
}

#Preview {
    LocalView(vm: .constant(CharacterViewModel()))
}
