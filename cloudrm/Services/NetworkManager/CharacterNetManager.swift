//
//  CharacterNetManager.swift
//  cloudrm
//
//  Created by Jean Laura on 11/01/25.
//

import Foundation

struct InfoResponse: Codable {
    var count : Int
    var pages : Int
    var next : String?
    var prev : String?
}

struct dtoCharacter: Codable {
    var info: InfoResponse
    var results: [Character]
}

final class CharacterNetManager {
    
    private let urlBase: String = "https://rickandmortyapi.com/api/character/"
    private let session = URLSession.shared
    
    private var nextLink: String?
    
    func getCharacters() async -> [Character]? {
        
        guard let realUrl = URL(string: urlBase) else {
            print()
            return nil
        }
        
        do {
            let (predata, _) = try await session.data(from: realUrl)
            let data = try JSONDecoder().decode(dtoCharacter.self, from: predata)
            
            self.nextLink = data.info.next
            let characters = data.results
            
            return characters
            
        } catch  {
            return nil
        }
    }
    
    func findCharacters(by name: String) async -> [Character]? {
        
        let urlString = urlBase + "?name=\(name)"
        
        guard let realUrl = URL(string: urlString) else {
            print()
            return nil
        }
        
        do {
            let (predata, _) = try await session.data(from: realUrl)
            let data = try JSONDecoder().decode(dtoCharacter.self, from: predata)
            
            self.nextLink = data.info.next
            let characters = data.results
            
            return characters
            
        } catch  {
            return nil
        }
        
    }
    
    func getMoreCharacters() async -> [Character]? {
        
        guard let realUrl = URL(string: nextLink ?? "") else {
            print()
            return nil
        }
        
        do {
            let (predata, _) = try await session.data(from: realUrl)
            let data = try JSONDecoder().decode(dtoCharacter.self, from: predata)

            self.nextLink = data.info.next
            let characters = data.results
            
            return characters
            
        } catch  {
            return nil
        }
    }
    
    //func get
}
