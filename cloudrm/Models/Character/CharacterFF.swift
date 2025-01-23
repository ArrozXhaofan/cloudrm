//
//  CharacterFB.swift
//  cloudrm
//
//  Created by Jean Laura on 13/01/25.
//

import Foundation
import FirebaseFirestore

struct CharacterFF: Codable, Identifiable {
    @DocumentID var identifier: String?
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: infoDTO
    var location: infoDTO
    var image: String
    var episode: [String]
    var url: String
    var created: String
}
