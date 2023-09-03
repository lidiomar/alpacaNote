//
//  AlpacaNoteApp.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 23/11/22.
//

import SwiftUI
import AlpacaNoteFramework
import CoreData

@main
struct AlpacaNoteApp: App {
    private var notesViewModel = NotesListContentViewModelImpl(noteStorage: AlpacaNoteNoteStorage.shared)
    private var saveNoteViewModel = SaveNoteViewModel(noteStorage: AlpacaNoteNoteStorage.shared)
    private var deleteNoteViewModel = DeleteNoteViewModel(noteStorage: AlpacaNoteNoteStorage.shared)
    
    var body: some Scene {
        WindowGroup {
            ContentViewComposer.composeWith(notesViewModel: notesViewModel,
                                            manageNoteViewModel: deleteNoteViewModel)
        }
    }
}

final class ContentViewComposer {
    private init() {}
    
    static func composeWith<T, U>(notesViewModel: T, manageNoteViewModel: U) -> some View where T: NotesListContentViewModel, U: ManageNoteViewModel {
        return ContentView<T, U>(noteListContent: NotesListContentComposer.composeWith(viewModel: manageNoteViewModel)).environmentObject(notesViewModel)
    }
}

final class NotesListContentComposer {
    private init() {}
    
    static func composeWith<T>(viewModel: T) -> (NoteContent) -> NotesListContent<T> where T: ManageNoteViewModel {
        return { note in
            return NotesListContent(content: note, manageNoteViewModel: viewModel)
        }
    }
}
