//
//  a.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import Foundation
import Combine
import AlpacaNoteFramework

final class NotesListContentViewModelPreview: NotesListContentViewModel {
    var state: NoteListLoadingState = .loaded([
        Note(id: UUID(), title: "Note 1", description: "Description 1"),
        Note(id: UUID(), title: "Note 2", description: "Description 2"),
        Note(id: UUID(), title: "Note 3", description: "Description 3"),
        Note(id: UUID(), title: "Note 4", description: "Description 4"),
        Note(id: UUID(), title: "Note 5", description: "Description 5"),
        Note(id: UUID(), title: "Note 6", description: "Description 6"),
    ])
    
    func fetchNotes() {}
}
