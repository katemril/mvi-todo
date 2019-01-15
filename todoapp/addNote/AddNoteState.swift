//
//  State.swift
//  todoapp
//
//  Created by Kate Mril on 1/8/19.
//  Copyright © 2019 weightwatchers. All rights reserved.
//

import UIKit

struct AddNoteState {
    
    private var note: NoteModel?
    
    enum Message {
        case addNote(NoteModel)
    }
    
    mutating func send(_ message: Message) {
        switch message {
        case .addNote(let note):
            Store.shared.add(note: note)
        }
    }
    
    var addedNote: NoteModel? {
        return note
    }
    
}
