//
//  CharacterViewDetails.swift
//  cloudrm
//
//  Created by Jean Laura on 14/01/25.
//

import SwiftUI

struct CharacterViewDetails: View {
    
    @Binding var manager: CharacterViewModel
    @Environment(\.dismiss) var dismiss
    
    var mixGradients: [LinearGradient] = [
        LinearGradient(colors: [.red, .blue],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing),
        LinearGradient(colors: [.yellow, .green],
                       startPoint: .topTrailing,
                       endPoint: .bottomLeading)
    ]
    
    var character: Character
    
    var body: some View {
        ScrollView {
            
            VStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                } placeholder: {
                    ProgressView()
                }
            }
            .frame(width: 100, height: 100)
            .background {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(lineWidth: 3)
                    .foregroundStyle(mixGradients[0])
                    .padding(-15)
                    .shadow(color: .blue, radius: 10)
            }
            .padding()
            
            Text(character.name)
                .font(.title2)
                .fontWeight(.heavy)
                .padding()
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                if let key = character.identifier {
                    Text(key)
                        .font(.caption)
                } else {
                    Text("#\(character.id)")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CharacterViewDetails(manager: .constant(CharacterViewModel()),
                             character: .objTest)
    }
}
