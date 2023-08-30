//
//  NotesListContent.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import SwiftUI
import AlpacaNoteFramework
import CoreData

struct NotesListContent: View {
    @ObservedObject var content: NoteContent
    
    var body: some View {
        List {
            ForEach(content.notes) { note in
                NavigationLink(destination: { addNewNoteView() },
                               label: { NotesListContentRow(note: note) })
            }
        }
        .listStyle(PlainListStyle())
        .padding(.top, 20)
    }
    
    private func addNewNoteView() -> ManageNoteView<SaveNoteViewModelImpl, NotesListContentViewModelImpl> {
        return ManageNoteView(saveNoteViewModel: saveNoteViewModel())
    }
    
    // TODO: Change the location of view model creation
    private func saveNoteViewModel() -> SaveNoteViewModelImpl {
        var storage: NoteStorage
        do {
            storage = try CoreDataNoteStorage(storeURL: NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("feed-store.sqlite"))
        } catch {
            storage = NullStorage()
        }
        return SaveNoteViewModelImpl(noteStorage: storage)
    }
}

struct NotesListContent_Previews: PreviewProvider {
    static var previews: some View {
        NotesListContent(content: NoteContent(notes: [Note(id: UUID(), title: "Title", description: "Description")]))
    }
}
