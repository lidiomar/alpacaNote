//
//  SaveNoteViewModelImpl.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 30/08/23.
//

import Foundation
import AlpacaNoteFramework

class UpdateNoteViewModel: ManageNoteViewModel {
    @Published var state: ManageNoteState = .idle
    private var noteStorage: NoteStorage
    
    init(noteStorage: NoteStorage) {
        self.noteStorage = noteStorage
    }
    
    func manage(note: Note) {
        state = .processing
        do {
            try noteStorage.updateNote(note.convert())
            state = .success
        } catch {
            state = .error
        }
    }
    
    func updateStateTo(_ state: ManageNoteState) {
        self.state = state
    }
}
