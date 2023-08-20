//
//  Note.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import Foundation

public class NoteContent: ObservableObject {
    @Published var notes: [Note]
    
    init(notes: [Note]) {
        self.notes = notes
    }
}

public class Note: Identifiable, ObservableObject {
    @Published public var id: UUID
    @Published var title: String
    @Published var description: String
    
    public init(id: UUID, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
}
