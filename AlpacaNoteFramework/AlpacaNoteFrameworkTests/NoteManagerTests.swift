//
//  AlpacaNoteFrameworkTests.swift
//  AlpacaNoteFrameworkTests
//
//  Created by Lidiomar Fernando dos Santos Machado on 08/12/22.
//

import XCTest
@testable import AlpacaNoteFramework

final class NoteManagerTests: XCTestCase {
    
    func test_createNewNote_shouldCallSuccessCompletion_whenCreatedWithSuccess() {
        let noteMessagesMock = NoteMessagesMock()
        let noteStorageMock = NoteStorageMock()
        noteStorageMock.shouldCreateWithSuccess = true
        let sut = NoteManager(noteStorage: NoteStorageMock(), noteMessages: noteMessagesMock)
        let expectation = expectation(description: "Expect create new note")
        var receivedSuccessMessage = ""
        sut.successCompletion = { successMessage in
            receivedSuccessMessage = successMessage
            expectation.fulfill()
        }
        
        sut.createNewNote(withText: "A simple text")
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedSuccessMessage, noteMessagesMock.createNewNoteWithSuccessMessage)
    }
    
    func test_createNewNote_shouldCallErrorCompletion_whenCreatedWithError() {
        let noteMessagesMock = NoteMessagesMock()
        let noteStorageMock = NoteStorageMock()
        noteStorageMock.shouldCreateWithSuccess = false
        let sut = NoteManager(noteStorage: noteStorageMock, noteMessages: noteMessagesMock)
        let expectation = expectation(description: "Expect create new note")
        var receivedErrorMessage = ""
        sut.failureCompletion = { errorMessage in
            receivedErrorMessage = errorMessage
            expectation.fulfill()
        }
        
        sut.createNewNote(withText: "A simple text")
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedErrorMessage, noteMessagesMock.createNewNoteErrorMessage)
    }
}

private final class NoteStorageMock: NoteStorage {
    var shouldCreateWithSuccess = true
    func createNewNote(withText text: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if shouldCreateWithSuccess {
            completion(.success(()))
            return
        }
        completion(.failure(NSError(domain: "A mocked error", code: 0)))
    }
}

private struct NoteMessagesMock: NoteMessages {
    var createNewNoteErrorMessage = "An error occurred."
    var createNewNoteWithSuccessMessage = "Note created with success."
}

