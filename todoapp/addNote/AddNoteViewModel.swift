//
//  AddNoteViewModel.swift
//  todoapp
//
//  Created by Kate Mril on 1/8/19.
//  Copyright © 2019 weightwatchers. All rights reserved.
//

protocol AddNoteViewModelDelegate: class {
    func renderState(new: AddNoteState)
}

class AddNoteViewModel {
    
    let noteModel: NoteModel
    weak var delegate: AddNoteViewModelDelegate?
    let store: Store
    
    // A new state triggers the UI update on the view
    var state: AddNoteState = AddNoteState() {
        didSet {
            update(new: state)
        }
    }
    
    private func update(new: AddNoteState) {
        delegate?.renderState(new: new)
    }
    
    init(noteModel: NoteModel, store: Store = Store.shared) {
        self.noteModel = noteModel
        self.store = store
    }

    /*
        Reducer produces a new state after applying the changes to a previous state
     */
    func reducer(change: AddNoteChange) {
        switch change {
        case .validating:
            var copyState = AddNoteState()
            copyState.isValidating = true
            state = copyState
        case .noteAddSuccess:
            var copyState = AddNoteState()
            copyState.note = state.note
            copyState.isNoteAdded = true
            state = copyState
        case .noteAddError:
            var copyState = AddNoteState()
            copyState.isError = true
            state = copyState
        case .noteAddValidationError:
            var copyState = AddNoteState()
            copyState.isValidationError = true
            state = copyState
        }
    }
    
    /*
        Actions triggered by a user
     */
    func performAction(action: AddNoteAction) {
        switch action {
        case let .addNote(note: note):
            addNote(note: note) { (change) in
                self.reducer(change: change)
            }
        }
    }
    
    /*
        API call
    */
    private func addNote(note: NoteModel, completion: @escaping (_ change: AddNoteChange) -> Void) {
        if !isNoteValid(note: note) {
            completion(.noteAddValidationError)
            return
        }
        store.add(note: note, success: { (notes) in
            completion(.noteAddSuccess)
        }) { (error) in
            completion(.noteAddError)
        }
    }
    
    private func isNoteValid(note: NoteModel) -> Bool {
        return note.note.trimmingCharacters(in: .whitespacesAndNewlines).count > 3
    }
    
}
