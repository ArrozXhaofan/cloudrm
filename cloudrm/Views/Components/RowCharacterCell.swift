//
//  RowCharacterCell.swift
//  cloudrm
//
//  Created by Jean Laura on 14/01/25.
//

import SwiftUI

struct RowCharacterCell: View {
    
    var value: Character
    
    @Binding var vm: CharacterViewModel
    @State var isOnPreView: Bool = false
    
    var body: some View {
        NavigationLink(value: value) {
            HStack {
                Text("#\(value.id.description)")
                    .bold()
                Text(value.name)
                Spacer()
            }
            .onLongPressGesture(perform: {
                isOnPreView.toggle()
            })
            .popover(isPresented: $isOnPreView) {
                VStack {
                    CharacterPopView(vm: $vm, character: value)
                }
                .frame(maxWidth: .infinity, maxHeight: 301)
                .presentationDetents([.height(300), .height(301)])
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            RowCharacterCell(value: .objTest, vm: .constant(CharacterViewModel()))
        }
        .navigationDestination(for: Character.self) { item in
            CharacterViewDetails(manager: .constant(CharacterViewModel()), character: item)
        }
    }
}
