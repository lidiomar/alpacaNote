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
            case let .failure(error):
                print(error)
            }
        }
    }
}

final class AlpacaNoteTests: XCTestCase {
    
    func test_createNewNote_shouldCallNoteStorageCreateNewNote() {
        let noteStorageSpy = NoteStorageSpy()
        let sut = NoteManager(noteStorage: noteStorageSpy, noteMessages: NoteMessagesMock())
        
        sut.createNewNote(withText: "A simple text")
        
        XCTAssertTrue(noteStorageSpy.createNoteWasCalled)
    }
    
    func test_createNewNote_shouldCallSuccessCompletion_whenCreatedWithSuccess() {
        let noteMessagesMock = NoteMessagesMock()
        let sut = NoteManager(noteStorage: NoteStorageSpy(), noteMessages: noteMessagesMock)
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
}

private final class NoteStorageSpy: NoteStorage {
    var createNoteWasCalled = false
    
    func createNewNote(withText text: String, completion: @escaping (Result<Void, Error>) -> Void) {
        createNoteWasCalled = true
        completion(.success(()))
    }
}

private struct NoteMessagesMock: NoteMessages {
    var createNewNoteWithSuccessMessage = "Note created with success."
}

