//
//  Character.swift
//  cloudrm
//
//  Created by Jean Laura on 11/01/25.
//

import Foundation

struct Character: Hashable, Identifiable, Codable {
    let identifier: String?
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: infoDTO
    var location: infoDTO
    let image: String
    var episode: [String]
    let url: String
    let created: String
}

struct infoDTO: Hashable, Codable {
    var name: String
    let url: String
}

