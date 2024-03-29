//
//  State.swift
//  todoapp
//
//  Created by Kate Mril on 1/8/19.
//  Copyright © 2019 weightwatchers. All rights reserved.
//

// State is a data structure
// a version of a reducer that reduces a model action/ a view action into a state
struct State {
    private var notes: [NoteModel] = []
    private var _isLoading = false
    
    enum Message {
        case loading
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
            _isLoading = false
            return nil
        case .loading:
            _isLoading = true
            return nil
        }
    }
    
    var allNotes: [NoteModel] {
        return notes
    }
    
    var isLoading: Bool {
        return _isLoading
    }
}
