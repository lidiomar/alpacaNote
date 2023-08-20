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
    var state: NoteListLoadingState = .empty
    
    func fetchNotes() {}
}
