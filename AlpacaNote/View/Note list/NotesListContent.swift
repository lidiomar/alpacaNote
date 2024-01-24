//
//  NotesListContent.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import SwiftUI
import AlpacaNoteFramework

struct NotesListContent<T>: View where T: ManageNoteViewModel {
    @ObservedObject var content: NoteContent
    @ObservedObject var manageNoteViewModel: T
    @EnvironmentObject var navigationComposer: Assembler
    
    var body: some View {
        List {
            ForEach(content.notes) { note in
                NavigationLink(destination: navigationComposer.manageNoteView(withNote: note),
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
        let a = NoteContent(notes: [
            Note(id: UUID(), title: "Note 1", description: "Description 1"),
            Note(id: UUID(), title: "Note 2", description: "Description 2"),
            Note(id: UUID(), title: "Note 3", description: "Description 3"),
            Note(id: UUID(), title: "Note 4", description: "Description 4"),
            Note(id: UUID(), title: "Note 5", description: "Description 5"),
            Note(id: UUID(), title: "Note 6", description: "Description 6"),
        ])
        return NotesListContent(content: a, manageNoteViewModel: DeleteNoteViewModelPreview()).environmentObject(Assembler())
    }
}
