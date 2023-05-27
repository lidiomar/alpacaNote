//
//  AlpacaNoteApp.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 23/11/22.
//

import SwiftUI

@main
struct AlpacaNoteApp: App {
    @StateObject private var notesModelData = NotesModelData()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(notesModelData)
        }
    }
}
