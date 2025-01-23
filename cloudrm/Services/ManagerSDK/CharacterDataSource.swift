//
//  CharacterDataSource.swift
//  cloudrm
//
//  Created by Jean Laura on 13/01/25.
//

import Foundation
import FirebaseFirestore

final class CharacterDataSource {
    
    private let manager = Firestore.firestore()
    private let collectionName = "characters"
    
    func getAllData() async throws -> [CharacterFF] {
        
        let request = try await manager.collection(collectionName).getDocuments()
        let preFetch = request.documents
        
        let data = preFetch.map {try? $0.data(as: CharacterFF.self)}.compactMap({$0})

        return data
    }
    
    func addCharacter(value: Character) throws {
        try manager.collection(collectionName).addDocument(from: value)
    }
    
    func deleteCharacter(value: String) {
        manager.collection(collectionName).document(value).delete()
    }
    
 
}
