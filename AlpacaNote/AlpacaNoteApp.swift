//
//  AlpacaNoteApp.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 23/11/22.
//

import SwiftUI
import AlpacaNoteFramework
import CoreData

// TODO: Extract the NotesListContentViewModelImpl creation
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
            ContentView<NotesListContentViewModelImpl>().environmentObject(notesViewModel)
        }
    }
}
