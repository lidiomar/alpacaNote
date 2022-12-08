//
//  NoteStorage.swift
//  AlpacaNoteFramework
//
//  Created by Lidiomar Fernando dos Santos Machado on 08/12/22.
//

import Foundation

protocol NoteStorage {
    func createNewNote(withText text: String, completion: @escaping (Result<Void, Error>) -> Void)
}
