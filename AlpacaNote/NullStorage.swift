//
//  NullStorage.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 26/08/23.
//

import Foundation
import AlpacaNoteFramework

class NullStorage: NoteStorage {
    func updateNote(_ note: AlpacaNoteFramework.Note) throws {}
    
    func deleteNote(byId id: UUID) throws {}
    
    func storeNewNote(_ note: AlpacaNoteFramework.Note) throws {}
    
    func retrieveNotes() throws -> [AlpacaNoteFramework.Note]? {
        return nil
    }
}
