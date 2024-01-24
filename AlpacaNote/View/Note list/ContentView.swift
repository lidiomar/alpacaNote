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


class FetchNotesManagement: ObservableObject, Equatable {
    static func == (lhs: FetchNotesManagement, rhs: FetchNotesManagement) -> Bool {
        lhs.shouldFetch == rhs.shouldFetch
    }
    
    @Published
    var shouldFetch: Bool = false
}

struct ContentView<T>: View where T: NotesListContentViewModel {
    @EnvironmentObject var navigationComposer: Assembler
    @ObservedObject var notesListContentViewModel: T
    @StateObject var fetchNotesManagement = FetchNotesManagement()
    
    var body: some View {
        NavigationView {
            VStack {
                switch notesListContentViewModel.state {
                case let .loaded(notes):
                    navigationComposer.notesListContent(withNoteContent: NoteContent(notes: notes))
                case .empty:
                    NoContent()
                case .loading, .idle:
                    Text("Loading...")
                case .failure:
                    Text("Failure")
                }
            }
            .toolbar {
                NavigationLink(destination: navigationComposer.manageNoteView) {
                    Image(systemName: "doc.badge.plus")
                }.buttonStyle(GrowingButton())
            }
            .navigationBarTitle("Notes", displayMode: .large)
        }.onChange(of: fetchNotesManagement.shouldFetch) { shouldFetch in
            if shouldFetch {
                notesListContentViewModel.fetchNotes()
                self.fetchNotesManagement.shouldFetch = false
            }
        }
        .task {
            notesListContentViewModel.fetchNotes()
        }.environmentObject(fetchNotesManagement)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(notesListContentViewModel: NotesListContentViewModelPreview()).environmentObject(Assembler())
    }
}
