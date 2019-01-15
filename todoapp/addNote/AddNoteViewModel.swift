//
//  AddNoteViewModel.swift
//  todoapp
//
//  Created by Kate Mril on 1/8/19.
//  Copyright © 2019 weightwatchers. All rights reserved.
//

class AddNoteViewModel {
    
    let noteModel: NoteModel
    
    weak var delegate: NoteViewModelDelegate?
    
    var state: AddNoteState = AddNoteState() {
        didSet {
            update(old: oldValue)
        }
    }
    
    init(noteModel: NoteModel) {
        self.noteModel = noteModel
    }
    
    // reducer
    private func update(old: AddNoteState) {
        
    }
    
    func addNote(note: NoteModel) {
        state.send(.addNote(note))
    }

}
