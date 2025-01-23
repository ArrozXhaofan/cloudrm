//
//  CharacterCloudRepo.swift
//  cloudrm
//
//  Created by Jean Laura on 13/01/25.
//

import Foundation

final class CharacterCloudRepo {
    
    private let manager: CharacterDataSource
    
    init(CharacterDataProvider: CharacterDataSource = CharacterDataSource()) {
        self.manager = CharacterDataProvider
    }
    
    func getCharacter() async -> [Character] {
        do {
            let data = try await manager.getAllData().map {$0.ToModel()}
            return data
        } catch  {
            print("Ocurrio un error")
            return []
        }
    }
    
    func addCharacter(value: Character) throws {
        try manager.addCharacter(value: value)
    }
    
    func deleteCharacter(key: String) throws {
        manager.deleteCharacter(value: key)
    }
    
}
