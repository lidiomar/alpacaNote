//
//  Composer.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 24/01/24.
//

import Foundation
import SwiftUI

class Assembler: ObservableObject {
    static let noteStorage = AlpacaNoteSwiftDataNoteStorage.shared
    
    static func root() -> some View {
        return composeContentView(contentViewModel: NotesListContentViewModelImpl(noteStorage: Assembler.noteStorage))
    }
    
    func notesListContent(withNoteContent note: NoteContent) -> some View {
        return composeNotesListContent(noteContent: note, deleteViewModel: ManageNoteViewModelImpl(noteStorage: Assembler.noteStorage, operation: .delete))
    }
    
    func manageNoteView() -> some View {
        return composeManageNoteView(saveNoteViewModel: ManageNoteViewModelImpl(noteStorage: Assembler.noteStorage, operation: .save))
    }
    
    func manageNoteView(withNote note: Note) -> some View {
        return composeManageNoteView(withNote: note, updateViewModel: ManageNoteViewModelImpl(noteStorage: Assembler.noteStorage, operation: .update))
    }
}

private extension Assembler {
    func composeNotesListContent<T>(noteContent: NoteContent, deleteViewModel: T) -> some View where T: ManageNoteViewModel {
        return NotesListContent(content: noteContent, manageNoteViewModel: deleteViewModel)
    }
    
    func composeManageNoteView<T>(saveNoteViewModel: T) -> ManageNoteView<T> {
        return ManageNoteView(manageNoteViewModel: saveNoteViewModel)
    }
    
    func composeManageNoteView<T>(withNote note: Note, updateViewModel: T) -> ManageNoteView<T> {
        return ManageNoteView(manageNoteViewModel: updateViewModel, note: note)
    }
    
    static func composeContentView(contentViewModel: NotesListContentViewModelImpl) -> some View {
        return ContentView(notesListContentViewModel: contentViewModel)
    }
}
