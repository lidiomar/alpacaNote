//
//  Note+Convert.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 30/08/23.
//

import Foundation
import AlpacaNoteFramework

extension Note {
    func convert() -> AlpacaNoteFramework.Note {
        return AlpacaNoteFramework.Note(id: self.id, title: self.title, description: self.description)
    }
}
