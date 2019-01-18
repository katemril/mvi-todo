//
//  CreateNoteViewController.swift
//  todoapp
//
//  Created by Kate Mril on 1/3/19.
//  Copyright © 2019 weightwatchers. All rights reserved.
//

import UIKit

extension AddNoteViewController: AddNoteViewModelDelegate {
    
    func renderState(new: AddNoteState) {
        if new.isValidating { } // no-op
        
        if new.isValidationError {
            LoadingIndicatorView.show(view, loadingText: "A note should be at least 3 characters long")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                LoadingIndicatorView.hide()
            }
        }
        
        if new.isError {
            LoadingIndicatorView.show(view, loadingText: "Error adding a note")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                LoadingIndicatorView.hide()
            }
        }
        
        if new.isNoteAdded {
            navigationController?.popViewController(animated: true)
        }
    }
}

class AddNoteViewController: UIViewController {
    
    private var viewModel: AddNoteViewModel
    let textView = UITextView()
    var overlay: UIView?
    
    override init(nibName: String?, bundle: Bundle?) {
        self.viewModel = AddNoteViewModel(noteModel: NoteModel(note: ""))
        super.init(nibName: nibName, bundle: bundle)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = textView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(save(barButton:))
        )
    }
    
    @objc func save(barButton: UIBarButtonItem) {
        let model = NoteModel(note: textView.text)
        viewModel.performAction(action: .addNote(note: model))
    }
    
}
