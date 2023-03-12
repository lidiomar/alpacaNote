//
//  Note.swift
//  AlpacaNoteFramework
//
//  Created by Lidiomar Fernando dos Santos Machado on 22/02/23.
//

import Foundation

public struct Note: Equatable {
    public let id: UUID
    public let title: String
    public let description: String
    
    public init(id: UUID, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
}
