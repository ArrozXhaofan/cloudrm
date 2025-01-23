//
//  ContentView.swift
//  cloudrm
//
//  Created by Jean Laura on 11/01/25.
//

import SwiftUI

struct NetView: View {
    
    @Binding var vm: CharacterViewModel
    
    @State var coordenateY: CGFloat = 0
    @State var coordenateYMax: CGFloat = 0
    
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(vm.charactersNet, id: \.id) { character in
                            RowCharacterCell(value: character, vm: $vm)
                    }
                    HStack {
                        Spacer()
                        if isLoading {
                            ProgressView()
                        } else {
                            Button {
                                Task {
                                    isLoading.toggle()
                                    await vm.getMoreCharacterAPI()
                                    isLoading.toggle()
                                }
                            } label: {
                                Text("more")
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 100, height: 30)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.blue)
                            }
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Network")
            .navigationDestination(for: Character.self) { obj in
                CharacterViewDetails(manager: $vm, character: obj)
            }
        }
        
    }
    
}

#Preview {
    NetView(vm: .constant(CharacterViewModel()))
}
