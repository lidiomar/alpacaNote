//
//  NotesListContent.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import SwiftUI

struct NotesListContent: View {
    @ObservedObject var content: NoteContent

    var body: some View {
        List {
            ForEach(content.notes) { note in
            label: do {
                    NotesListContentRow(note: note)
                }
            }
        }
        .listStyle(PlainListStyle())
        .padding(.top, 20)
    }
}

struct NotesListContent_Previews: PreviewProvider {
    static var previews: some View {
        NotesListContent(content: NoteContent(notes: [Note(id: UUID(), title: "Title", description: "Description")]))
    }
}
