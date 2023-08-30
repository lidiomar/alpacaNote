//
//  NoteListLoadingState.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 20/08/23.
//

import Foundation

enum NoteListLoadingState {
    case idle
    case loading
    case loaded([Note])
    case empty
    case failure
}
