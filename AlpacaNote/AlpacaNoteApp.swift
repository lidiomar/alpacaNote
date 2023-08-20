//
//  AlpacaNoteApp.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 23/11/22.
//

import SwiftUI
import AlpacaNoteFramework
import CoreData

class NullStorage: NoteStorage {
    func deleteNote(byId id: UUID) throws {}
    
    func storeNewNote(_ note: AlpacaNoteFramework.Note) throws {}
    
    func retrieveNotes() throws -> [AlpacaNoteFramework.Note]? {
        return nil
    }
}

@main
struct AlpacaNoteApp: App {
    private var notesViewModel: NotesListContentViewModelImpl {
        var storage: NoteStorage
        do {
            storage = try CoreDataNoteStorage(storeURL: NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("feed-store.sqlite"))
        } catch {
            storage = NullStorage()
        }
        return NotesListContentViewModelImpl(noteStorage: storage)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: notesViewModel)
        }
    }
}
