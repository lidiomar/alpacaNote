//
//  a.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import Foundation
import Combine

final class NotesModelData: ObservableObject {
    @Published var notes: [Note] = [
        Note(id: UUID(), title: "Note 1", description: "Description 1"),
        Note(id: UUID(), title: "Note 2", description: "Description 2"),
        Note(id: UUID(), title: "Note 3", description: "Description 3"),
        Note(id: UUID(), title: "Note 4", description: "Description 4"),
        Note(id: UUID(), title: "Note 5", description: "Description 5"),
        Note(id: UUID(), title: "Note 6", description: "Description 6"),
        Note(id: UUID(), title: "Note 7", description: "Description 7"),
        Note(id: UUID(), title: "Note 8", description: "Description 8"),
        Note(id: UUID(), title: "Note 9", description: "Description 9"),
        Note(id: UUID(), title: "Note 10", description: "Description 10"),
        Note(id: UUID(), title: "Note 11", description: "Description 11"),
        Note(id: UUID(), title: "Note 12", description: "Description 12")
        
    ]
}
