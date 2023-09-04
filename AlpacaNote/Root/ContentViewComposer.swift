//
//  ContentViewComposer.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 03/09/23.
//

import Foundation
import SwiftUI

final class ContentViewComposer {
    private init() {}
    
    static func composeWith<T, U, V, X>(contentViewModel: T, deleteViewModel: U, saveViewModel: V, updateViewModel: X) -> some View where T: NotesListContentViewModel, U: ManageNoteViewModel, V: ManageNoteViewModel, X: ManageNoteViewModel {
        
        let notesListContent = NotesListContentComposer.composeWith(contentViewModel: contentViewModel,
                                                                    deleteViewModel: deleteViewModel,
                                                                    updateViewModel: updateViewModel)
        
        let noteView = ManageNoteViewComposer.composeWith(manageViewModel: saveViewModel,
                                                          notesListContentViewModel: contentViewModel)
        
        return ContentView<T, U, V, X>(noteListContent: notesListContent,
                                       noteView: noteView).environmentObject(contentViewModel)
    }
}
