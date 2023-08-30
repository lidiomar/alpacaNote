//
//  AddNewNoteView.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 20/08/23.
//

import SwiftUI

struct AddNewNoteView<T, U>: View where T: SaveNoteViewModel, U: NotesListContentViewModel {
    @ObservedObject var saveNoteViewModel: T
    @EnvironmentObject var notesListContentViewModel: U
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            switch saveNoteViewModel.state {
            case .idle:
                MainView(saveNoteViewModel: saveNoteViewModel)
            case .success:
                Text("Success").onAppear {
                    notesListContentViewModel.fetchNotes()
                    presentationMode.wrappedValue.dismiss()
                }
            case .saving:
                Text("Saving...")
            case .error:
                Text("Error :(")
            }
        }
    }
}

struct MainView<T>: View where T: SaveNoteViewModel {
    @ObservedObject var saveNoteViewModel: T
    @State private var noteTitle = ""
    @State private var noteDescription = ""
    @State private var isSaveButtonDisabled = true
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading) {
                Text("Title:")
                TextField("", text: $noteTitle).textFieldStyle(.roundedBorder)
            }
            VStack(alignment: .leading) {
                Text("Description:")
                VStack {
                    TextEditor(text: $noteDescription)
                        .background(Color.primary.colorInvert())
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1 / 3)
                                .opacity(0.3))
                }
            }
            Spacer()
            SaveButton(isSaveButtonDisabled: $isSaveButtonDisabled) {
                saveNoteViewModel.save(note: Note(id: UUID(), title: noteTitle, description: noteDescription))
            }
        }.onChange(of: noteTitle) { _ in
            shouldDisableSaveButton()
        }.onChange(of: noteDescription) { _ in
            shouldDisableSaveButton()
        }
        .navigationBarTitle("Add a new note", displayMode: .inline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
    }
    
    private func shouldDisableSaveButton() {
        isSaveButtonDisabled = noteTitle.isEmpty || noteDescription.isEmpty
    }
}

struct SaveButton: View {
    @Binding var isSaveButtonDisabled: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("Save").frame(maxWidth: .infinity)
        }
        .buttonStyle(GrowingButtonSave(isSaveButtonDisabled: isSaveButtonDisabled))
        .padding(.horizontal, 32)
        .disabled(isSaveButtonDisabled)
    }
}

struct GrowingButtonSave: ButtonStyle {
    var isSaveButtonDisabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(isSaveButtonDisabled ? .gray : .blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct AddNewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewNoteView<SaveNoteViewModelPreview, NotesListContentViewModelPreview>(saveNoteViewModel: SaveNoteViewModelPreview())
    }
}
