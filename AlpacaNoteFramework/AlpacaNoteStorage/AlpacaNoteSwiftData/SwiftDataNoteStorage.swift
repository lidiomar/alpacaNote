//
//  SwiftDataNoteStorage.swift
//  AlpacaNoteFramework
//
//  Created by Lidiomar Fernando dos Santos Machado on 24/01/24.
//

import SwiftData

public final class SwiftDataNoteStorage: NoteStorage {
    var context: ModelContext
    
    public init(url: URL) throws {
        let configuration = ModelConfiguration(url: url)
        let container = try ModelContainer(for: NoteSwiftData.self, configurations: configuration)
        context = ModelContext(container)
    }
    
    public func deleteNote(byId id: UUID) throws {
        let predicate = #Predicate<NoteSwiftData> { $0.id == id }
        try context.delete(model: NoteSwiftData.self, where: predicate)
    }
    
    public func storeNewNote(_ note: Note) throws {
        context.insert(NoteSwiftData(id: note.id, noteDescription: note.description, noteTitle: note.title))
    }
    
    public func retrieveNotes() throws -> [Note]? {
        let notes = try context.fetch(FetchDescriptor<NoteSwiftData>())
        return notes.map { Note(id: $0.id, title: $0.noteTitle, description: $0.noteDescription) }
    }
    
    public func updateNote(_ note: Note) throws {
        let a: UUID = note.id
        let predicate = #Predicate<NoteSwiftData> { $0.id == a }
        let fetchDescriptor = FetchDescriptor<NoteSwiftData>(predicate: predicate)
        let noteSwiftData = try context.fetch(fetchDescriptor).first
        noteSwiftData?.noteTitle = note.title
        noteSwiftData?.noteDescription = note.description
    }
}
