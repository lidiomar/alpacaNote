//
//  NotesListContentViewModel.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 19/07/23.
//

import Foundation

protocol NotesListContentViewModel: ObservableObject {
    var state: NoteListLoadingState { get }
    func fetchNotes()
}
