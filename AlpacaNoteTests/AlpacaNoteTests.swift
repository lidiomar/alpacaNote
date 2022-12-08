//
//  AlpacaNoteTests.swift
//  AlpacaNoteTests
//
//  Created by Lidiomar Fernando dos Santos Machado on 23/11/22.
//

import XCTest

protocol NoteStorage {
    func createNewNote(withText text: String, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol NoteMessages {
    var createNewNoteWithSuccessMessage: String { get }
    var createNewNoteErrorMessage: String { get }
}

final class NoteManager {
    private var noteStorage: NoteStorage
    private var noteMessages: NoteMessages
    
    var successCompletion: ((String) -> Void)?
    var failureCompletion: ((String) -> Void)?
    
    init(noteStorage: NoteStorage, noteMessages: NoteMessages) {
        self.noteStorage = noteStorage
        self.noteMessages = noteMessages
    }
    
    func createNewNote(withText text: String) {
        noteStorage.createNewNote(withText: text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.successCompletion?(self.noteMessages.createNewNoteWithSuccessMessage)
            case .failure:
                self.failureCompletion?(self.noteMessages.createNewNoteErrorMessage)
            }
        }
    }
}

final class AlpacaNoteTests: XCTestCase {
    
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

