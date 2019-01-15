//
//  CreateNoteViewController.swift
//  todoapp
//
//  Created by Kate Mril on 1/3/19.
//  Copyright © 2019 weightwatchers. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    private var viewModel: AddNoteViewModel
    let textView = UITextView()
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(save(barButton:))
        )
    }
    
    @objc func save(barButton: UIBarButtonItem) {
        let model = NoteModel(note: textView.text)
        viewModel.addNote(note: model)
        
        navigationController?.popViewController(animated: true)
    }
    
}
