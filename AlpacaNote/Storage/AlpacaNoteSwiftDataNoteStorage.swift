//
//  AlpacaNoteSwiftDataNoteStorage.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 24/01/24.
//

import SwiftData
import AlpacaNoteFramework
import CoreData

final class AlpacaNoteSwiftDataNoteStorage {
    private init() {}
    
    static var shared: NoteStorage {
        var storage: NoteStorage
        do {
            storage = try SwiftDataNoteStorage(url: NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("alpaca-note-store.sqlite"))
        } catch {
            storage = NullStorage()
        }
        return storage
    }
}
