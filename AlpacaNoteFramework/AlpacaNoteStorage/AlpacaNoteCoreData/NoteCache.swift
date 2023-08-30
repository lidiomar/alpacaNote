//
//  NoteCache+CoreDataClass.swift
//  AlpacaNoteCoreData
//
//  Created by Lidiomar Fernando dos Santos Machado on 11/03/23.
//
//

import Foundation
import CoreData

@objc(NoteCache)
class NoteCache: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var noteDescription: String
    @NSManaged var noteTitle: String
}

extension NoteCache {
    static func fetchNotes(viewContext: NSManagedObjectContext) throws -> [NoteCache] {
        let request = NSFetchRequest<NoteCache>(entityName: "NoteCache")
        return try viewContext.fetch(request)
    }
    
    static func deleteNote(viewContext: NSManagedObjectContext, id: UUID) throws {
        let note = try NoteCache.fecthNote(withId: id, viewContext: viewContext)
        try note.map(viewContext.delete).map(viewContext.save)
    }
    
    static func updateNote(viewContext: NSManagedObjectContext, id: UUID, noteTitle: String, noteDescription: String) throws {
        guard let fetchedNote = try NoteCache.fecthNote(withId: id, viewContext: viewContext) else {
            throw NSError(domain: "ID not found in the cache.", code: 0)
        }
        
        fetchedNote.noteTitle = noteTitle
        fetchedNote.noteDescription = noteDescription
        try viewContext.save()
    }
    
    private static func fecthNote(withId id: UUID, viewContext: NSManagedObjectContext) throws -> NoteCache? {
        let request = NSFetchRequest<NoteCache>(entityName: "NoteCache")
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)
        return try viewContext.fetch(request).first
        
    }
}
