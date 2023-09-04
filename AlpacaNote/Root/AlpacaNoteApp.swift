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
    private var updateNoteViewModel = UpdateNoteViewModel(noteStorage: AlpacaNoteNoteStorage.shared)
    
    var body: some Scene {
        WindowGroup {
            ContentViewComposer.composeWith(contentViewModel: notesViewModel,
                                            deleteViewModel: deleteNoteViewModel,
                                            saveViewModel: saveNoteViewModel,
                                            updateViewModel: updateNoteViewModel)
        }
    }
}
