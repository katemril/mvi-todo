//
//  State.swift
//  todoapp
//
//  Created by Kate Mril on 1/8/19.
//  Copyright © 2019 weightwatchers. All rights reserved.
//

/*
 ata class State(val notes: List<ViewNote> = listOf(),
 @Transient val isIdle: Boolean = false,
 @Transient val isLoading: Boolean = false,
 @Transient val isError: Boolean = false) : BaseState, Parcelable

 */

// State is a data structure
// a version of a reduce that reduces a model action/ a view action into a state
struct State {
    private var notes: [NoteModel] = []
    
    enum Message {
        case dataReceived([NoteModel])
        case reload
    }
    
    // this is equvalent to action in android?
    enum Command {
        case loadData(message: ([NoteModel]) -> Message)
    }
    
    mutating func send(_ message: Message) -> Command?{
        switch message {
        case .reload:
           return .loadData(message: Message.dataReceived)
        case .dataReceived(let allNotes):
            notes = allNotes
            return nil
        }
    }
    
    var allNotes: [NoteModel] {
        return notes
    }
}
