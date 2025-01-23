//
//  CharacterPopView.swift
//  cloudrm
//
//  Created by Jean Laura on 14/01/25.
//

import SwiftUI

struct CharacterPopView: View {
    
    @Environment(\.authViewModel) var auth
    @Binding var vm: CharacterViewModel
    var character: Character
    
    @State var isLoading: Bool = true
    @State var cloudIsReady: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 6) {
                Text("reference #\(character.id)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
                
                Text(character.identifier ?? "without identifier XXX-XXX-X-XX-X")
                    .font(.system(size: 10, weight: .light, design: .monospaced))
                
            }
            .foregroundStyle(.gray)
            
            
            Text(character.name)
                .font(.title)
                .fontWeight(.heavy)
            
            HStack(alignment: .bottom, spacing: 5) {
                Text("Specie")
                    .font(.caption)
                Text(character.species)
                    .foregroundStyle(.purple)
                    .font(.title2)
                    .fontWeight(.heavy)
                
            }
            .foregroundStyle(.purple)
            
            HStack(spacing: 20) {
                
                if vm.findInDisk(id: character.id) {
                    Button("Ready Disk", systemImage: "checkmark.rectangle.stack.fill"){}
                        .disabled(true)
                        .buttonStyle(.bordered)
                        .tint(.pink)
                    
                } else {
                    Button("to Disk", systemImage: "externaldrive.fill.badge.plus") {
                        vm.addCharacterDisk(value: character)
                    }
                    .buttonStyle(.bordered)
                    .tint(.pink)
                }
                
                if auth.userCloud == nil {
                    Button("Need key", systemImage: "key.icloud.fill"){}
                        .disabled(true)
                        .buttonStyle(.bordered)
                        .tint(.blue)
                } else {
                    if isLoading {
                        VStack {ProgressView()}
                            .frame(width: 120)
                    } else {
                        if cloudIsReady {
                            Button("ready Cloud", systemImage: "checkmark.icloud.fill"){}
                                .disabled(true)
                                .buttonStyle(.bordered)
                                .tint(.blue)
                            
                        } else {
                            Button("to Cloud", systemImage: "icloud.and.arrow.up.fill") {
                                Task {
                                    isLoading = true
                                    await vm.addCharacterCloud(value: character)
                                    cloudIsReady = vm.findInCloud(id: character.id)
                                    isLoading = false
                                    
                                }
                            }
                            .buttonStyle(.bordered)
                            .tint(.blue)
                        }
                    }
                }
  
            }
            .padding(8)
            
            HStack(spacing: 17) {
                Text(character.status)
                    .font(.caption)
                    .padding(6)
                    .padding(.horizontal)
                
                    .background {
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.primary.opacity(0.5), lineWidth: 0.5)
                    }
                
                Text(character.type)
                    .font(.caption)
                    .padding(6)
                    .padding(.horizontal)
                
                    .background {
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.primary.opacity(0.5), lineWidth: 0.5)
                    }
                
                Text(character.gender)
                    .font(.caption)
                    .padding(6)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.primary.opacity(0.5), lineWidth: 0.5)
                    }
            }
            
        }
        .onAppear {
            cloudIsReady = vm.findInCloud(id: character.id)
            isLoading = false
        }
    }
}

#Preview {
    CharacterPopView(vm: .constant(CharacterViewModel()),
                     character: .objTest)
        .environment(\.authViewModel, AuthViewModel())
}
