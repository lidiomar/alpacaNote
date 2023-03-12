//
//  CoreDataNoteStorageTests.swift
//  AlpacaNoteCoreDataTests
//
//  Created by Lidiomar Fernando dos Santos Machado on 12/03/23.
//

import XCTest
import AlpacaNoteFramework
import AlpacaNoteCoreData

final class CoreDataNoteStorageTests: XCTestCase, NoteStorageSpecs {
    func test_retrieveNotes_deliversEmptyOnEmptyCache() {
        let sut = makeSUT()
        assertThatRetrieveNotesDeliversEmptyOnEmptyCache(on: sut)
    }
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> NoteStorage {
        let storeURL = URL(fileURLWithPath: "/dev/null")
        let sut = try! CoreDataNoteStorage(storeURL: storeURL)
        return sut
    }
}
