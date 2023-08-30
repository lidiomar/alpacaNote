//
//  SaveNoteModel.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 26/08/23.
//

import Foundation

protocol SaveNoteViewModel: ObservableObject {
    var state: ManageNoteState { get }
    func save(note: Note)
}
