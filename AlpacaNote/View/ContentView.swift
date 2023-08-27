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
    @ObservedObject var viewModel: T
    @State private var isShowingDetail = false
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
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
                NavigationLink(destination: AddNewNoteView(saveNoteViewModel: saveNoteViewModel(), isShowing: $isShowingDetail), isActive: $isShowingDetail) {
                    Image(systemName: "doc.badge.plus")
                }.buttonStyle(GrowingButton())
            }
            .navigationBarTitle("Notes", displayMode: .large)
        }
        .task {
            viewModel.fetchNotes()
        }
    }
    
    // TODO: Change the view model creation location
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
        ContentView(viewModel: NotesListContentViewModelPreview())
    }
}
