//
//  Note.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import Foundation

public struct Note: Identifiable {
    public let id: UUID
    public let title: String
    public let description: String
    
    public init(id: UUID, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
}
