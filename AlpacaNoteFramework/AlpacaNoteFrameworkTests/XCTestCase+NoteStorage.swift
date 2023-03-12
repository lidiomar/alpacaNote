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
}
