//
//  CharacterSD.swift
//  cloudrm
//
//  Created by Jean Laura on 12/01/25.
//

import Foundation
import SwiftData

@Model
final class CharacterSD {
    @Attribute(.unique) var identifier: String
    var idReference: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: infoSD
    var location: infoSD
    var image: String
    var episode: [String]
    var url: String
    var created: String
    
    init(idReference: Int,
        name: String,
         status: String,
         species: String,
         type: String,
         gender: String,
         origin: infoSD,
         location: infoSD,
         image: String,
         episode: [String],
         url: String,
         created: String) {
        
        let uuid = UUID()
        let key = uuid.uuidString
        self.identifier = key
        self.idReference = idReference
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

@Model
final class infoSD {
    var name: String
    var url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}


    

/*
 
 {
   "id": 2,
   "name": "Morty Smith",
   "status": "Alive",
   "species": "Human",
   "type": "",
   "gender": "Male",
   "origin": {
     "name": "Earth",
     "url": "https://rickandmortyapi.com/api/location/1"
   },
   "location": {
     "name": "Earth",
     "url": "https://rickandmortyapi.com/api/location/20"
   },
   "image": "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
   "episode": [
     "https://rickandmortyapi.com/api/episode/1",
     "https://rickandmortyapi.com/api/episode/2",
     // ...
   ],
   "url": "https://rickandmortyapi.com/api/character/2",
   "created": "2017-11-04T18:50:21.651Z"
 }
 
 */

