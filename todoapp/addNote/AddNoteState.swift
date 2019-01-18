//
//  State.swift
//  todoapp
//
//  Created by Kate Mril on 1/8/19.
//  Copyright © 2019 weightwatchers. All rights reserved.
//

struct AddNoteState {
    
    var note: NoteModel?
    var isValidating = false
    var isValidationError = false
    var isNoteAdded = false
    var isError = false
}
