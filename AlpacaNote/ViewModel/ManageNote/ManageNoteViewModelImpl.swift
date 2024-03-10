//
//  ManageNoteViewModelImpl.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 10/03/24.
//

import Foundation
import AlpacaNoteFramework

class ManageNoteViewModelImpl: ManageNoteViewModel {
    @Published var state: ManageNoteState = .idle
    private var noteStorage: NoteStorage
    private var operation: ManageNoteOperation
    
    init(noteStorage: NoteStorage, operation: ManageNoteOperation) {
        self.noteStorage = noteStorage
        self.operation = operation
    }
    
    func manage(note: Note) {
        state = .processing
        do {
            switch operation {
            case .update:
                try update(note: note)
            case .delete:
                try delete(note: note)
            case .save:
                try save(note: note)
            }
            
            state = .success
        } catch {
            state = .error
        }
    }
    
    private func delete(note: Note) throws {
        try noteStorage.deleteNote(byId: note.id)
    }
    
    private func update(note: Note) throws {
        try noteStorage.updateNote(note.convert())
    }
    
    private func save(note: Note) throws {
        try noteStorage.storeNewNote(note.convert())
    }
}
