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
                NavigationLink(destination: { addNewNoteView(note: note) },
                               label: { NotesListContentRow(note: note) })
            }
        }
        .listStyle(PlainListStyle())
        .padding(.top, 20)
    }
    
    private func addNewNoteView(note: Note) -> ManageNoteView<UpdateNoteViewModel, NotesListContentViewModelImpl> {
        return ManageNoteView(manageNoteViewModel: updateNoteViewModel(), note: note)
    }
    
    // TODO: Change the location of view model creation
    private func updateNoteViewModel() -> UpdateNoteViewModel {
        var storage: NoteStorage
        do {
            storage = try CoreDataNoteStorage(storeURL: NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("feed-store.sqlite"))
        } catch {
            storage = NullStorage()
        }
        return UpdateNoteViewModel(noteStorage: storage)
    }
}

struct NotesListContent_Previews: PreviewProvider {
    static var previews: some View {
        NotesListContent(content: NoteContent(notes: [Note(id: UUID(), title: "Title", description: "Description")]))
    }
}
