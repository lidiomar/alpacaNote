//
//  AddNewNoteView.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 20/08/23.
//

import SwiftUI

struct GrowingButtonB: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct AddNewNoteView: View {
    @State private var noteTitle: String = ""
    @State private var noteDescription: String = ""
    
    var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Title:")
                    TextField("", text: $noteTitle).textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .center) {
                    Text("Description")
                    VStack {
                        TextEditor(text: $noteDescription)
                            .background(Color.primary.colorInvert())
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1 / 3)
                                    .opacity(0.3))
                    }
                    Button("Save") {
                        print("save")
                    }.buttonStyle(GrowingButtonB())
                    Spacer()
                }
            }
            .navigationBarTitle("Add a new note", displayMode: .inline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
        
    }
}

struct AddNewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewNoteView()
    }
}
