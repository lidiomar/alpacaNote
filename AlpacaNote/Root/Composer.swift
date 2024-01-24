//
//  Composer.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 24/01/24.
//

import Foundation
import SwiftUI

class Assembler: ObservableObject {
    private var saveNoteViewModel = SaveNoteViewModel(noteStorage: AlpacaNoteNoteStorage.shared)
    private var deleteNoteViewModel = DeleteNoteViewModel(noteStorage: AlpacaNoteNoteStorage.shared)
    private var updateNoteViewModel = UpdateNoteViewModel(noteStorage: AlpacaNoteNoteStorage.shared)
    private static var notesViewModel = NotesListContentViewModelImpl(noteStorage: AlpacaNoteNoteStorage.shared)
    
    static func root() -> some View {
        return composeContentView(contentViewModel: notesViewModel)
    }
    
    func notesListContent(withNoteContent note: NoteContent) -> some View {
        return composeNotesListContent(noteContent: note, deleteViewModel: deleteNoteViewModel)
    }
    
    func manageNoteView() -> some View {
        return composeManageNoteView(saveNoteViewModel: saveNoteViewModel)
    }
    
    func manageNoteView(withNote note: Note) -> some View {
        return composeManageNoteView(withNote: note, updateViewModel: updateNoteViewModel)
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
