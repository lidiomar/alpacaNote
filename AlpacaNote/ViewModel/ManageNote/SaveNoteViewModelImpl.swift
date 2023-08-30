//
//  SaveNoteViewModelImpl.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 26/08/23.
//

import Foundation
import AlpacaNoteFramework

class SaveNoteViewModelImpl: ManageNoteViewModel {
    @Published var state: ManageNoteState = .idle
    private var noteStorage: NoteStorage
    
    init(noteStorage: NoteStorage) {
        self.noteStorage = noteStorage
    }
    
    func manage(note: Note) {
        state = .processing
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
