//
//  NotesListContentViewModel.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 08/06/23.
//

import Foundation
import AlpacaNoteFramework

class NotesListContentViewModelImpl: NotesListContentViewModel {
    @Published var state: NoteListLoadingState = .idle
    private var noteStorage: NoteStorage
    
    init(noteStorage: NoteStorage) {
        self.noteStorage = noteStorage
    }
    
    func fetchNotes() {
        state = .loading
        do {
            guard let retrievedNotes = try noteStorage.retrieveNotes(), !retrievedNotes.isEmpty else {
                state = .empty
                return
            }
            state = .loaded(retrievedNotes.convert())
        } catch {
            state = .failure
        }
    }
}

private extension Array where Element == AlpacaNoteFramework.Note {
    func convert() -> [Note] {
        return map { Note(id: $0.id, title: $0.title, description: $0.description) }
    }
}
