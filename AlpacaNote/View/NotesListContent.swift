//
//  NotesListContent.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import SwiftUI

struct NotesListContent: View {
    @EnvironmentObject var notesModelData: NotesModelData
    
    init() {}
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notesModelData.notes) { note in
                label: do {
                        NotesListContentRow(note: note)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .padding(.top, 20)
            .navigationBarTitle("Notes")
        }
    }
}

struct NotesListContent_Previews: PreviewProvider {
    static var previews: some View {
        NotesListContent().environmentObject(NotesModelData())
    }
}
