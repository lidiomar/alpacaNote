//
//  ContentView.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 23/11/22.
//

import SwiftUI
import AlpacaNoteFramework

struct ContentView<T>: View where T: NotesListContentViewModel {
    @ObservedObject var viewModel: T
    
    var body: some View {
        NavigationView {
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
        }.task {
            viewModel.fetchNotes()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: NotesListContentViewModelPreview())
    }
}
