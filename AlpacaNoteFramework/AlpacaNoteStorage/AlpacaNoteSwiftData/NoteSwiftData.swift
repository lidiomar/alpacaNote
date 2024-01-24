//
//  NoteSwiftData.swift
//  AlpacaNoteFramework
//
//  Created by Lidiomar Fernando dos Santos Machado on 24/01/24.
//

import SwiftData

@Model
class NoteSwiftData {
    var id: UUID
    var noteDescription: String
    var noteTitle: String
    
    init(id: UUID, noteDescription: String, noteTitle: String) {
        self.id = id
        self.noteDescription = noteDescription
        self.noteTitle = noteTitle
    }
}
