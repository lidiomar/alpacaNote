//
//  NotesListContent.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import SwiftUI
import AlpacaNoteFramework
import CoreData

struct NotesListContent<T>: View where T: ManageNoteViewModel {
    @ObservedObject var content: NoteContent
    @ObservedObject var manageNoteViewModel: T
    
    var body: some View {
        List {
            ForEach(content.notes) { note in
                NavigationLink(destination: { addNewNoteView(note: note) },
                               label: { NotesListContentRow(note: note) })
            }.onDelete(perform: delete)
        }
        .listStyle(PlainListStyle())
        .padding(.top, 20)
    }
    
    private func delete(at offsets: IndexSet) {
        if let index = offsets.first, content.notes.indices.contains(index) {
            let note = content.notes[index]
            manageNoteViewModel.manage(note: note)
        }
        content.notes.remove(atOffsets: offsets)
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
        NotesListContent(content: NoteContent(notes: [Note(id: UUID(), title: "Title", description: "Description")]), manageNoteViewModel: DeleteNoteViewModelPreview())
    }
}
