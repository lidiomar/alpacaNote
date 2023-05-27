//
//  d.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import SwiftUI
import AlpacaNoteFramework

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
    static var notesModelData = NotesModelData()

    static var previews: some View {
        NotesListContentRow(note: notesModelData.notes[0])
    }
}

