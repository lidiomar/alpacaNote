//
//  CoreDataNoteStorage.swift
//  AlpacaNoteCoreData
//
//  Created by Lidiomar Fernando dos Santos Machado on 22/02/23.
//

import CoreData
import AlpacaNoteFramework

public final class CoreDataNoteStorage {
    private static let modelName = "AlpacaNoteCoreDataModel"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataNoteStorage.self))
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }
    
    public init(storeURL: URL) throws {
        guard let model = CoreDataNoteStorage.model else {
            throw StoreError.modelNotFound
        }
        
        do {
            container = try NSPersistentContainer.load(name: CoreDataNoteStorage.modelName, model: model, url: storeURL)
            context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }
    
    func performSync<R>(_ action: (NSManagedObjectContext) -> Result<R, Error>) throws -> R {
        let context = self.context
        var result: Result<R, Error>!
        context.performAndWait { result = action(context) }
        return try result.get()
    }
    
    private func cleanUpReferencesToPersistentStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }
    
    deinit {
        cleanUpReferencesToPersistentStores()
    }
}
 
extension CoreDataNoteStorage: NoteStorage {
    public func deleteNote(byId id: UUID) throws {
        try performSync { context in
            Result {
                try NoteCache.deleteNote(viewContext: context, id: id)
            }
        }
    }
    
    public func retrieveNotes() throws -> [AlpacaNoteFramework.Note]? {
        try performSync { context in
            Result {
                let notes = try NoteCache.fetchNotes(viewContext: context)
                return notes.map { Note(id: $0.id, title: $0.noteTitle, description: $0.noteDescription) }
            }
        }
    }
    
    public func storeNewNote(_ note: AlpacaNoteFramework.Note) throws {
        try performSync { context in
            Result {
                let noteCache = NoteCache(context: context)
                noteCache.noteTitle = note.title
                noteCache.noteDescription = note.description
                try context.save()
            }
        }
    }
}
