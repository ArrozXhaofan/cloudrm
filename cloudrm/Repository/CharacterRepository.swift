//
//  CharacterReposotory.swift
//  cloudrm
//
//  Created by Jean Laura on 12/01/25.
//

import Foundation
import SwiftData

@MainActor
final class CharacterRepository {
    
    let container: ModelContainer = setup(inDisk: false)
    
    var context: ModelContext {
        container.mainContext
    }
    
    
    static func setup(inDisk: Bool) -> ModelContainer {
        
        let setting = ModelConfiguration(isStoredInMemoryOnly: !inDisk)
        let schema = Schema([CharacterSD.self])
        
        do {
            let container = try ModelContainer(for: schema, configurations: [setting])
            return container
            
            
        } catch {
            fatalError("Error al crear la base de datos: \(error.localizedDescription)")
        }
    }
    
    func getCharacter() -> [Character] {
                
        let sort1 = SortDescriptor<CharacterSD>(\.name)
        let fetchDescriptor = FetchDescriptor(sortBy: [sort1])
        
        guard let preData = try? context.fetch(fetchDescriptor) else {
            return []
        }
        
        let charecters = preData.map { $0.ToModel()}
        
        return charecters
    }
    
    func addCharacter(data: Character) throws {

        let character = data.ToStorable()
        
        context.insert(character)
        try context.save()
    }
    
    func deleteCharacter(identifier: String) throws {
        
        let predicate = #Predicate<CharacterSD> {
            $0.identifier == identifier
        }
        
        try context.delete(model: CharacterSD.self, where: predicate)
        try context.save()
    }
    
}
