//
//  AddNewNoteView.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 20/08/23.
//

import SwiftUI

struct ManageNoteView<T>: View where T: ManageNoteViewModel {
    @ObservedObject var manageNoteViewModel: T
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var fetchNotesManagement: FetchNotesManagement
    var note: Note?
    
    // TODO: Fix Hardcoded strings
    var body: some View {
        VStack {
            switch manageNoteViewModel.state {
            case .idle:
                MainView(manageNoteViewModel: manageNoteViewModel,
                         noteId: note?.id ?? UUID(),
                         noteTitle: note?.title ?? "",
                         noteDescription: note?.description ?? "",
                         isSaveButtonDisabled: true)
            case .success:
                Text("Success").onAppear {
                    fetchNotesManagement.shouldFetch = true
                    presentationMode.wrappedValue.dismiss()
                }
            case .processing:
                Text("Saving...")
            case .error:
                Text("Error :(")
            }
        }
    }
}

private struct MainView<T>: View where T: ManageNoteViewModel {
    @ObservedObject var manageNoteViewModel: T
    @State var noteId: UUID
    @State var noteTitle: String
    @State var noteDescription: String
    @State var isSaveButtonDisabled: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading) {
                Text("Title:")
                TextField(noteTitle, text: $noteTitle).textFieldStyle(.roundedBorder)
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
                manageNoteViewModel.manage(note: Note(id: noteId, title: noteTitle, description: noteDescription))
            }
        }.onChange(of: noteTitle) { _ in
            shouldDisableSaveButton()
        }.onChange(of: noteDescription) { _ in
            shouldDisableSaveButton()
        }
        .navigationBarTitle("Add new note", displayMode: .inline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
    }
    
    private func shouldDisableSaveButton() {
        isSaveButtonDisabled = noteTitle.isEmpty || noteDescription.isEmpty
    }
}

private struct SaveButton: View {
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
        ManageNoteView<SaveNoteViewModelPreview>(manageNoteViewModel: SaveNoteViewModelPreview())
    }
}
