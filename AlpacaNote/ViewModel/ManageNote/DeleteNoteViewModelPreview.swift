//
//  DeleteNoteViewModelPreview.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 30/08/23.
//

import Foundation

class DeleteNoteViewModelPreview: ManageNoteViewModel {
    var state: ManageNoteState = .error
    
    func manage(note: Note) {
        print("Delete")
    }
    
    func updateStateTo(_ state: ManageNoteState) {
        self.state = state
    }
}

