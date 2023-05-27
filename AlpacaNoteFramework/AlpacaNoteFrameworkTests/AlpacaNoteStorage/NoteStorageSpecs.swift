//
//  NoteStorageSpecs.swift
//  AlpacaNoteFramework
//
//  Created by Lidiomar Fernando dos Santos Machado on 12/03/23.
//

import Foundation

public protocol NoteStorageSpecs {
    func test_retrieveNotes_deliversEmptyOnEmptyCache()
    func test_retrieveNotes_hasNoSideEffectsOnEmptyCache()
    func test_retrieveNotes_deliversFoundValuesOnNonEmptyCache()
    func test_retrieveNotes_hasNoSideEffectsOnNonEmptyCache()
    
    func test_insertNotes_deliversNoErrorOnEmptyCache()
    func test_insertNotes_deliversNoErrorOnNonEmptyCache()
    
    func test_delete_deliversNoErrorOnEmptyCache()
    func test_delete_hasNoSideEffectsOnEmptyCache()
    func test_delete_deliversNoErrorOnNonEmptyCache()
    func test_delete_removesPreviouslyInsertedCache()
}

protocol FailableRetrieveNoteStorageSpecs: NoteStorageSpecs {
    func test_retrieveNotes_deliversFailureOnRetrievalError()
    func test_retrieveNotes_hasNoSideEffectsOnFailure()
}

protocol FailableInsertNotesFeedStoreSpecs: NoteStorageSpecs {
    func test_insertNotes_deliversErrorOnInsertionError()
    func test_insertNotes_hasNoSideEffectsOnInsertionError()
}

protocol FailableDeleteNotesFeedStoreSpecs: NoteStorageSpecs {
    func test_deleteNotes_deliversErrorOnDeletionError()
    func test_deleteNotes_hasNoSideEffectsOnDeletionError()
}

typealias FailableNoteStoreSpecs = FailableRetrieveNoteStorageSpecs & FailableInsertNotesFeedStoreSpecs & FailableDeleteNotesFeedStoreSpecs
