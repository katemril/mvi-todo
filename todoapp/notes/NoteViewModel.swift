//
//  NoteViewModel.swift
//  todoapp
//
//  Created by Kate Mril on 1/7/19.
//  Copyright © 2019 weightwatchers. All rights reserved.
//

import Foundation

/*
 sealed class Change {
    object Loading : Change()
    data class Notes(val notes: List<ViewNote>) : Change()
    data class Error(val throwable: Throwable?) : Change()
}
*/
// Note: a partial state. Transition between a backend state to front end state
enum Change {
    case loading
    case notes(([NoteModel]))
    case error
}

protocol NoteViewModelDelegate: class {
    func renderState(old: State)
}


// Action -> Change -> State
// View -> Command -> Change -> State
// A view model doesnt have access to a model directly -> only through a use case
class NoteViewModel {
    
    let noteModel: NoteModel
    let store: Store
    weak var delegate: NoteViewModelDelegate?
    
    var state: State = State() {
        didSet {
            update(old: oldValue)
        }
    }
    
    init(noteModel: NoteModel, store: Store = Store.shared) {
        self.noteModel = noteModel
        self.store = store
    }
    
    // Binding
    private func update(old: State) {
        delegate?.renderState(old: old)
    }
    
    // Bind actions: action to change
    func send(_ message: State.Message) {
        guard let command = state.send(message) else { return }
        
        switch command {
        case let .loadData(message: _):
            let change = loadNotes()
            reducer(message: message, change: change)
        }
    }
    
    // Reducer on change: change to state
    // Android: private val reducer: Reducer<State, Change> = { state, change ->
    func reducer(message: State.Message, change: Change) {
        switch change {
        case .loading:
            print("")
        case .error:
            print("")
        case .notes(let notes):
            _ = state.send(.dataReceived(notes))
        }
    }
    
    func loadNotes() -> Change {
        let notes = store.fetchNotes()
        if notes.isEmpty {
            return .error
        } else {
            return .notes(notes)
        }
    }
    
}