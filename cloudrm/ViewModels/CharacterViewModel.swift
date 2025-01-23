//
//  CharacterViewModel.swift
//  cloudrm
//
//  Created by Jean Laura on 12/01/25.
//

import Foundation
import SwiftUI

@Observable
final class CharacterViewModel {
    
    var charactersNet: [Character] = []
    var charactersDisk: [Character] = []
    var charactersCloud: [Character] = []
    
    @MainActor private let reposoitory: CharacterRepository = CharacterRepository()
    private let netService: CharacterNetManager
    private let cloudService: CharacterCloudRepo
    
    
    init(netService: CharacterNetManager = CharacterNetManager(),
         cloudService: CharacterCloudRepo = CharacterCloudRepo()) {
        
        self.netService = netService
        self.cloudService = cloudService
        
        Task {
            await getAllCharacterAPI()
            await getAllCharacterDisk()
            await getAllCharacterCloud()
        }
    }
    
    //VIEW FUNCTIONS
    
    func findInDisk(id: Int) -> Bool {
        for i in charactersDisk {
            if i.id == id {
                return true
            }
        }
        return false
    }
    
    func findInCloud(id: Int) -> Bool {
        for i in charactersCloud {
            if i.id == id {
                return true
            }
        }
        return false
    }
    
    //API FUNCTIONS
    
    func getAllCharacterAPI() async {
        self.charactersNet = await netService.getCharacters() ?? []
    }
    
    func getMoreCharacterAPI() async {
        let characters = await netService.getMoreCharacters() ?? []
        
        withAnimation {
            self.charactersNet += characters
        }
    }
    
    func findCharctersAPIby(name: String) async -> [Character] {
        return await netService.findCharacters(by: name.lowercased()) ?? []
    }
    
    //REPOSITORY FUNTIONS
    
    @MainActor
    func getAllCharacterDisk()  {
        self.charactersDisk = reposoitory.getCharacter()
    }
    
    @MainActor
    func addCharacterDisk(value: Character) {
        do {
            try reposoitory.addCharacter(data: value)
            getAllCharacterDisk()

        } catch  {
            print("Error creating character: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func deleterCharacterDisk(value: Character) {
        
        guard let key = value.identifier else {
            print("Error at found key")
            return
        }
        
        do {
            try reposoitory.deleteCharacter(identifier: key)
            getAllCharacterDisk()
            
        } catch  {
            print("Error deleting character: \(error.localizedDescription)")
        }
    }
    
    //CLOUD FUNCTIONS
    func getAllCharacterCloud() async {
        self.charactersCloud = await cloudService.getCharacter()
    }
    
    func addCharacterCloud(value: Character) async {
        do {
            try cloudService.addCharacter(value: value)
            await getAllCharacterCloud()
            
        } catch  {
            print("Error creating character: \(error.localizedDescription)")
        }
    }
    
    func deleteCharacterCloud(value: Character) async {
        
        guard let key = value.identifier else {
            print("Error at found key")
            return
        }
        
        do {
            try cloudService.deleteCharacter(key: key)
            await getAllCharacterCloud()

        } catch  {
            print("Error at deleting character: \(error.localizedDescription)")
        }
        
    }
    
    
    
}
