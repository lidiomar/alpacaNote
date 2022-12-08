//
//  NoteManager.swift
//  AlpacaNoteFramework
//
//  Created by Lidiomar Fernando dos Santos Machado on 08/12/22.
//

import Foundation

final class NoteManager {
    private var noteStorage: NoteStorage
    private var noteMessages: NoteMessages
    
    var successCompletion: ((String) -> Void)?
    var failureCompletion: ((String) -> Void)?
    
    init(noteStorage: NoteStorage, noteMessages: NoteMessages) {
        self.noteStorage = noteStorage
        self.noteMessages = noteMessages
    }
    
    func createNewNote(withText text: String) {
        noteStorage.createNewNote(withText: text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.successCompletion?(self.noteMessages.createNewNoteWithSuccessMessage)
            case .failure:
                self.failureCompletion?(self.noteMessages.createNewNoteErrorMessage)
            }
        }
    }
}
