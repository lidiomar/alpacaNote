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

struct ContentView<T>: View where T: NotesListContentViewModel {
    @ObservedObject var viewModel: T
    
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
                NavigationLink(destination: AddNewNoteView()) {
                    Image(systemName: "doc.badge.plus")
                }.buttonStyle(GrowingButton())
            }
            .navigationBarTitle("Notes", displayMode: .large)
        }
        .task {
            viewModel.fetchNotes()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: NotesListContentViewModelPreview())
    }
}
