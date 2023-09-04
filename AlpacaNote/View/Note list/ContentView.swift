//
//  ContentView.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 23/11/22.
//

import SwiftUI
import AlpacaNoteFramework

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing])
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView<T, U, V, X>: View where T: NotesListContentViewModel, U: ManageNoteViewModel, V: ManageNoteViewModel, X: ManageNoteViewModel {
    @EnvironmentObject var notesListContentViewModel: T
    var noteListContent: (NoteContent) -> NotesListContent<U, X>
    var noteView: ManageNoteView<V>
    
    var body: some View {
        NavigationView {
            VStack {
                switch notesListContentViewModel.state {
                case let .loaded(notes):
                    noteListContent(NoteContent(notes: notes))
                case .empty:
                    NoContent()
                case .loading, .idle:
                    Text("Loading...")
                case .failure:
                    Text("Failure")
                }
            }
            .toolbar {
                NavigationLink(destination: noteView) {
                    Image(systemName: "doc.badge.plus")
                }.buttonStyle(GrowingButton())
            }
            .navigationBarTitle("Notes", displayMode: .large)
        }
        .task {
            notesListContentViewModel.fetchNotes()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView<NotesListContentViewModelPreview, DeleteNoteViewModelPreview, SaveNoteViewModelPreview, UpdateNoteViewModelPreview>(noteListContent: { _ in
            let content = NoteContent(notes: [Note(id: UUID(), title: "Title", description: "Description")])
            return NotesListContent(content: content, manageNoteViewModel: DeleteNoteViewModelPreview(), noteView: { _ in ManageNoteView(manageNoteViewModel: UpdateNoteViewModelPreview()) })
        }, noteView: ManageNoteView(manageNoteViewModel: SaveNoteViewModelPreview())).environmentObject(NotesListContentViewModelPreview())
    }
}
