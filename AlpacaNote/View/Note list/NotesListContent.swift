//
//  NotesListContent.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import SwiftUI
import AlpacaNoteFramework

struct NotesListContent<T, U>: View where T: ManageNoteViewModel, U: ManageNoteViewModel {
    @ObservedObject var content: NoteContent
    @ObservedObject var manageNoteViewModel: T
    var noteView: (Note?) -> ManageNoteView<U>
    
    var body: some View {
        List {
            ForEach(content.notes) { note in
                NavigationLink(destination: { noteView(note) },
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
}

struct NotesListContent_Previews: PreviewProvider {
    static var previews: some View {
        let noteContent = NoteContent(notes: [Note(id: UUID(), title: "Title", description: "Description")])
        let manageNoteView = ManageNoteView(manageNoteViewModel: UpdateNoteViewModelPreview())
        NotesListContent<DeleteNoteViewModelPreview, UpdateNoteViewModelPreview>(content: noteContent,
                                                                                 manageNoteViewModel: DeleteNoteViewModelPreview(),
                                                                                 noteView: { _ in manageNoteView })
    }
}
