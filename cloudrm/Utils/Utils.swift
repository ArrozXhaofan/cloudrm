//
//  File.swift
//  cloudrm
//
//  Created by Jean Laura on 13/01/25.
//

import Foundation

extension infoDTO {
    func toSD() -> infoSD {
        return infoSD(name: self.name, url: self.url)
    }
}

extension infoSD {
    func ToDto() -> infoDTO {
        return infoDTO(name: self.name, url: self.url)
    }
}

extension Character {
    
    static let objTest = Character(identifier: UUID().uuidString,
                                   id: 12,
                                   name: "Zahra Al-Husseini",
                                   status: "Alive",
                                   species: "Humanss",
                                   type: "Box",
                                   gender: "Woman",
                                   origin: .init(name: "Persia", url: "https://www.google.com/maps/place/Guangzhou+airport/@23.3959079,113.3079699,13z/data=!4m2!3m1!1s0x0:0xa2467af91f7f31a3?entry=ml&utm_campaign=ml-p&coh=230964"),
                                   location: .init(name: "Peru", url: "https://www.google.com/maps/place/Guangzhou+airport/@23.3959079,113.3079699,13z/data=!4m2!3m1!1s0x0:0xa2467af91f7f31a3?entry=ml&utm_campaign=ml-p&coh=230964"),
                                   image: "https://scontent-lim1-1.xx.fbcdn.net/v/t39.30808-6/438087741_7509108829202381_5286793440394153689_n.jpg?stp=cp6_dst-jpg_tt6&_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=PNROghiCZPQQ7kNvgF7MnLJ&_nc_zt=23&_nc_ht=scontent-lim1-1.xx&_nc_gid=AUgOzNcpekh80CftbE_Y8A8&oh=00_AYAgvgEzmfGG8xYDJJL_Oxq-1w2M49I8TxoL6OxD7KDVzA&oe=678C3BE1",
                                   episode: ["Hola", "Soy", "Jeanpiere Laura"],
                                   url:"https://www.google.com/maps/place/Guangzhou+airport/@23.3959079,113.3079699,13z/data=!4m2!3m1!1s0x0:0xa2467af91f7f31a3?entry=ml&utm_campaign=ml-p&coh=230964",
                                   created: Date.now.description)
    
    func ToStorable() -> CharacterSD {
        return CharacterSD(idReference: self.id,
                           name: self.name,
                           status: self.status,
                           species: self.species,
                           type: self.type,
                           gender: self.gender,
                           origin: self.origin.toSD(),
                           location: self.location.toSD(),
                           image: self.image,
                           episode: self.episode,
                           url: self.url,
                           created: self.created)
    }
}

extension CharacterSD {
    func ToModel() -> Character {
        return Character(identifier: self.identifier,
                         id: self.idReference,
                         name: self.name,
                         status: self.status,
                         species: self.species,
                         type: self.type,
                         gender: self.gender,
                         origin: self.origin.ToDto(),
                         location: self.location.ToDto(),
                         image: self.image,
                         episode: self.episode,
                         url: self.url,
                         created: self.created)
    }
}

extension CharacterFF {
    func ToModel() -> Character {
        return Character(identifier: self.identifier,
                         id: self.id,
                         name: self.name,
                         status: self.status,
                         species: self.species,
                         type: self.type,
                         gender: self.gender,
                         origin: self.origin,
                         location: self.location,
                         image: self.image,
                         episode: self.episode,
                         url: self.url,
                         created: self.created)
        
    }
}
