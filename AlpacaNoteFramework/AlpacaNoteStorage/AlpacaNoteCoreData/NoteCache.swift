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
    
    private static func fecthNote(withId id: UUID, viewContext: NSManagedObjectContext) throws -> NoteCache? {
        let request = NSFetchRequest<NoteCache>(entityName: "NoteCache")
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)
        return try viewContext.fetch(request).first
        
    }
}
