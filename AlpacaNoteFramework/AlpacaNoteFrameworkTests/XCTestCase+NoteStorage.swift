//
//  XCTestCase+NoteStorage.swift
//  AlpacaNoteFramework
//
//  Created by Lidiomar Fernando dos Santos Machado on 12/03/23.
//

import Foundation
import XCTest

public extension NoteStorageSpecs where Self: XCTestCase {
    func assertThatRetrieveNotesDeliversEmptyOnEmptyCache(on sut: NoteStorage, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: .success([]), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnEmptyCache(on sut: NoteStorage, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .success([]), file: file, line: line)
    }
    
    func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on sut: NoteStorage, file: StaticString = #filePath, line: UInt = #line) {
        let note = Note(id: UUID(), title: "A title", description: "A description")
        insert(note, to: sut)
        
        expect(sut, toRetrieve: .success([note]), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on sut: NoteStorage, file: StaticString = #filePath, line: UInt = #line) {
        
        let note = Note(id: UUID(), title: "A title", description: "A description")
        insert(note, to: sut)
        
        expect(sut, toRetrieveTwice: .success([note]), file: file, line: line)
    }
    
    func assertThatInsertDeliversNoErrorOnEmptyCache(on sut: NoteStorage, file: StaticString = #filePath, line: UInt = #line) {
        
        let note = Note(id: UUID(), title: "A title", description: "A description")
        let insertionError = insert(note, to: sut)
        
        XCTAssertNil(insertionError, "Expected to insert cache successfully", file: file, line: line)
    }
    
    func assertThatInsertDeliversNoErrorOnNonEmptyCache(on sut: NoteStorage, file: StaticString = #filePath, line: UInt = #line) {
        
        let note = Note(id: UUID(), title: "A title", description: "A description")
        insert(note, to: sut)
        
        let anotherNote = Note(id: UUID(), title: "Another title", description: "Another description")
        let insertionError = insert(anotherNote, to: sut)
        
        XCTAssertNil(insertionError, "Expected to override cache successfully", file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnEmptyCache(on sut: NoteStorage, file: StaticString = #filePath, line: UInt = #line) {
        let id = UUID()
        let note = Note(id: id, title: "A title", description: "A description")
        
        let deletionError = deleteCache(from: sut, byId: id)
        
        XCTAssertNil(deletionError, "Expected empty cache deletion to succeed", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnEmptyCache(on sut: NoteStorage, file: StaticString = #filePath, line: UInt = #line) {
        let id = UUID()
        let note = Note(id: id, title: "A title", description: "A description")
        deleteCache(from: sut, byId: id)
        
        expect(sut, toRetrieve: .success([]), file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnNonEmptyCache(on sut: NoteStorage, file: StaticString = #filePath, line: UInt = #line) {
        let id = UUID()
        let note = Note(id: id, title: "A title", description: "A description")
        insert(note, to: sut)
        
        let deletionError = deleteCache(from: sut, byId: id)
        
        XCTAssertNil(deletionError, "Expected non-empty cache deletion to succeed", file: file, line: line)
    }
    
    func assertThatDeleteRemovesPreviouslyInsertedCache(on sut: NoteStorage, file: StaticString = #filePath, line: UInt = #line) {
        let id = UUID()
        let note = Note(id: id, title: "A title", description: "A description")
        insert(note, to: sut)
        
        deleteCache(from: sut, byId: id)
        
        expect(sut, toRetrieve: .success([]), file: file, line: line)
    }
    
    func expect(_ sut: NoteStorage, toRetrieve expectedResult: Result<[Note]?, Error>, file: StaticString = #filePath, line: UInt = #line) {
        let retrievedResult = Result { try sut.retrieveNotes() }
        
        switch (expectedResult, retrievedResult) {
        case (.success(.none), .success(.none)),
             (.failure, .failure):
            break
            
        case let (.success(.some(expected)), .success(.some(retrieved))):
            XCTAssertEqual(retrieved, expected, file: file, line: line)
        default:
            XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
        }
    }
    
    func expect(_ sut: NoteStorage, toRetrieveTwice expectedResult: Result<[Note]?, Error>, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }
}

extension NoteStorageSpecs where Self: XCTestCase {
    @discardableResult
    func insert(_ note: Note, to sut: NoteStorage) -> Error? {
        do {
            try sut.storeNewNote(note)
            return nil
        } catch {
            return error
        }
    }
    
    @discardableResult
    func deleteCache(from sut: NoteStorage, byId id: UUID) -> Error? {
        do {
            try sut.deleteNote(byId: id)
            return nil
        } catch {
            return error
        }
    }
}
