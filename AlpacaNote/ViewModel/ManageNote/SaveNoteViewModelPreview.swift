//
//  SaveNoteViewModelPreview.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 26/08/23.
//

import Foundation

class SaveNoteViewModelPreview: ManageNoteViewModel {
    var state: ManageNoteState = .error
    
    func manage(note: Note) {
        print("Save")
    }
    
    func updateStateTo(_ state: ManageNoteState) {
        self.state = state
    }
}
