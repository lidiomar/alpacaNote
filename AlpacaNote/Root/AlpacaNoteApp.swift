//
//  AlpacaNoteApp.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 23/11/22.
//

import SwiftUI
import AlpacaNoteFramework
import CoreData

@main
struct AlpacaNoteApp: App {
    
    var body: some Scene {
        WindowGroup {
            Assembler.root().environmentObject(Assembler())
        }
    }
}
