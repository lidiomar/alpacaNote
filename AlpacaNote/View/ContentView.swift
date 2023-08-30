//
//  ContentView.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 23/11/22.
//

import SwiftUI
import AlpacaNoteFramework
import CoreData

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing])
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView<T>: View where T: NotesListContentViewModel {
    @EnvironmentObject var notesListContentViewModel: T
    
    var body: some View {
        NavigationView {
            VStack {
                switch notesListContentViewModel.state {
                case let .loaded(notes):
                    NotesListContent(content: NoteContent(notes: notes))
                case .empty:
                    NoContent()
                case .loading, .idle:
                    Text("Loading...")
                case .failure:
                    Text("Failure")
                }
            }
            .toolbar {
                NavigationLink(destination: ManageNoteView<SaveNoteViewModelImpl, NotesListContentViewModelImpl>(saveNoteViewModel: saveNoteViewModel())) {
                    Image(systemName: "doc.badge.plus")
                }.buttonStyle(GrowingButton())
            }
            .navigationBarTitle("Notes", displayMode: .large)
        }
        .task {
            notesListContentViewModel.fetchNotes()
        }
    }
    
    // TODO: Change the location of view model creation
    func saveNoteViewModel() -> SaveNoteViewModelImpl {
        var storage: NoteStorage
        do {
            storage = try CoreDataNoteStorage(storeURL: NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("feed-store.sqlite"))
        } catch {
            storage = NullStorage()
        }
        return SaveNoteViewModelImpl(noteStorage: storage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView<NotesListContentViewModelPreview>().environmentObject(NotesListContentViewModelPreview())
    }
}
