//
//  UpdateNoteViewModelPreview.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 03/09/23.
//

import Foundation
import AlpacaNoteFramework

class UpdateNoteViewModelPreview: ManageNoteViewModel {
    var state: ManageNoteState = .idle
    
    func manage(note: Note) {
        print("Update")
    }
    
    func updateStateTo(_ state: ManageNoteState) {
        self.state = state
    }
}
