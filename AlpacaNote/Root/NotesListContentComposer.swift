//
//  NotesListContentComposer.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 03/09/23.
//

import Foundation
import SwiftUI

final class NotesListContentComposer {
    private init() {}
    
    static func composeWith<T, U>(contentViewModel: any NotesListContentViewModel,
                                  deleteViewModel: T,
                                  updateViewModel: U) -> (NoteContent) -> NotesListContent<T, U> where T: ManageNoteViewModel, U: ManageNoteViewModel {
        return { note in
            NotesListContent(content: note, manageNoteViewModel: deleteViewModel) { note in
                ManageNoteViewComposer.composeWith(manageViewModel: updateViewModel,
                                                   notesListContentViewModel: contentViewModel,
                                                   note: note)
            }
        }
    }
}
