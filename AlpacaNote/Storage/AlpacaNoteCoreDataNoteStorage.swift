//
//  AlpacaNoteCoreDataNoteStorage.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 03/09/23.
//

import Foundation
import AlpacaNoteFramework
import CoreData

final class AlpacaNoteNoteStorage {
    
    private init() {}
    
    static var shared: NoteStorage {
        var storage: NoteStorage
        do {
            storage = try CoreDataNoteStorage(storeURL: NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("feed-store.sqlite"))
        } catch {
            storage = NullStorage()
        }
        return storage
    }
}
