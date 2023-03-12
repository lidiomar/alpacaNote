//
//  NoteStorage.swift
//  AlpacaNoteFramework
//
//  Created by Lidiomar Fernando dos Santos Machado on 08/12/22.
//

import Foundation

public protocol NoteStorage {
    func deleteNote(byId id: UUID) throws
    func storeNewNote(_ note: Note) throws
    func retrieveNotes() throws -> [Note]?
}
