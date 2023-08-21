//
//  NoContent.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 27/05/23.
//

import SwiftUI

struct NoContent: View {
    @EnvironmentObject var notesModelData: NotesListContentViewModelImpl
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Your list is empty.")
        }
    }
}

struct NoContentt_Previews: PreviewProvider {
    static var previews: some View {
        NoContent()
    }
}
