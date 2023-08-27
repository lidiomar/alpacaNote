//
//  SaveNoteViewModelImpl.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 26/08/23.
//

import Foundation
import AlpacaNoteFramework

class SaveNoteViewModelImpl: SaveNoteViewModel {
    @Published var state: SaveState = .idle
    private var noteStorage: NoteStorage
    
    init(noteStorage: NoteStorage) {
        self.noteStorage = noteStorage
    }
    
    func save(note: Note) {
        state = .saving
        do {
            try noteStorage.storeNewNote(note.convert())
            state = .success
        } catch {
            state = .error
        }
    }
}

private extension Note {
    func convert() -> AlpacaNoteFramework.Note {
        return AlpacaNoteFramework.Note(id: self.id, title: self.title, description: self.description)
    }
}
