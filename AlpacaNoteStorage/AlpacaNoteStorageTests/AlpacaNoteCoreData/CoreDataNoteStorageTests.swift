//
//  CoreDataNoteStorageTests.swift
//  AlpacaNoteCoreDataTests
//
//  Created by Lidiomar Fernando dos Santos Machado on 12/03/23.
//

import XCTest
import AlpacaNoteFramework
import AlpacaNoteStorage

final class CoreDataNoteStorageTests: XCTestCase, NoteStorageSpecs {
    func test_retrieveNotes_deliversEmptyOnEmptyCache() {
        let sut = makeSUT()
        assertThatRetrieveNotesDeliversEmptyOnEmptyCache(on: sut)
    }
    
    func test_retrieveNotes_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    func test_retrieveNotes_deliversFoundValuesOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on: sut)
    }
    
    func test_retrieveNotes_hasNoSideEffectsOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on: sut)
    }
    
    func test_insertNotes_deliversNoErrorOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
    }
    
    func test_insertNotes_deliversNoErrorOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatInsertDeliversNoErrorOnNonEmptyCache(on: sut)
    }
    
    func test_delete_deliversNoErrorOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatDeleteDeliversNoErrorOnEmptyCache(on: sut)
    }
    
    func test_delete_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatDeleteHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    func test_delete_deliversNoErrorOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatDeleteDeliversNoErrorOnNonEmptyCache(on: sut)
    }
    
    func test_delete_removesPreviouslyInsertedCache() {
        let sut = makeSUT()
        
        assertThatDeleteRemovesPreviouslyInsertedCache(on: sut)
    }
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> NoteStorage {
        let storeURL = URL(fileURLWithPath: "/dev/null")
        let sut = try! CoreDataNoteStorage(storeURL: storeURL)
        return sut
    }
}
