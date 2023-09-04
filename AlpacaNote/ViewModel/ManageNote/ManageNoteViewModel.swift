//
//  SaveNoteModel.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 26/08/23.
//

import Foundation

protocol ManageNoteViewModel: ObservableObject {
    var state: ManageNoteState { get }
    func updateStateTo(_ state: ManageNoteState)
    func manage(note: Note)
}
