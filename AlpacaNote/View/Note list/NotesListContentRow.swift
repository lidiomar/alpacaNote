//
//  d.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import SwiftUI

struct NotesListContentRow: View {
    var note: Note

    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
            Text(note.description)
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        NotesListContentRow(note: Note(id: UUID(), title: "Title", description: "Description"))
    }
}

