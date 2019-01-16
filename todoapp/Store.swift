//
//  Store.swift
//  todoapp
//
//  Created by Kate Mril on 1/8/19.
//  Copyright © 2019 weightwatchers. All rights reserved.
//

import UIKit

final class Store {
    
    private var notes: [NoteModel] = []
    static let shared = Store()
    
    func fetchNotes(success: @escaping (_ posts: [NoteModel]) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            success(self.notes)
        }
    }
    
    func add(note: NoteModel) {
        notes.append(note)
    }

}
