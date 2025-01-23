//
//  SearchView.swift
//  cloudrm
//
//  Created by Jean Laura on 13/01/25.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var vm: CharacterViewModel
    
    @State var txtSearch: String = ""
    @State var characters: [Character] = []
    
    var body: some View {
        NavigationStack {
            
            VStack {
                if characters.isEmpty {
                    ContentUnavailableView("Search for characters!",
                                           systemImage: "mail.and.text.magnifyingglass")
                } else {
                    List {
                        ForEach(characters, id: \.hashValue) { character in
                            Text(character.name)
                        }
                        
                    }
                    
                }
                
                
            }
            .onChange(of: txtSearch) { _, newValue in
                Task {
                    characters = await vm.findCharctersAPIby(name: newValue)
                }
            }
            .navigationTitle("Search")
            .searchable(text: $txtSearch,
                        placement: .automatic,
                        prompt: "Search by name")
            .textInputAutocapitalization(.never)

        }
    }
}

#Preview {
    SearchView(vm: .constant(CharacterViewModel()))
}
