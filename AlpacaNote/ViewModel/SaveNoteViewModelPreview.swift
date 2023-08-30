//
//  SaveNoteViewModelPreview.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 26/08/23.
//

import Foundation

class SaveNoteViewModelPreview: SaveNoteViewModel {
    var state: ManageNoteState = .error
    
    func save(note: Note) {
        print("Save")
    }
}
