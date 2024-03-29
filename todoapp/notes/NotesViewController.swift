//
//  ViewController.swift
//  todoapp
//
//  Created by Kate Mril on 1/3/19.
//  Copyright © 2019 weightwatchers. All rights reserved.
//

import UIKit

extension NotesViewController: NoteViewModelDelegate {
    
    func renderState(new: State) {
        if new.isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            tableView.reloadData()
        }
    }
}

class NotesViewController: UIViewController {
    
    private var viewModel: NoteViewModel
    lazy var searchController: UISearchController = self.todoSearchController()
    let tableView = UITableView()
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override init(nibName: String?, bundle: Bundle?) {
        self.viewModel = NoteViewModel(noteModel: NoteModel(note: ""))
        super.init(nibName: nibName, bundle: bundle)
        self.viewModel.delegate = self
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = tableView
        setupActivityIndicator()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.send(.reload)
    }

}

extension NotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state.allNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.state.allNotes[indexPath.row].note
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            
        }
        edit.backgroundColor = .orange
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
        }
        delete.backgroundColor = .blue
        
        return [edit, delete]
    }
    
}

extension NotesViewController: UITableViewDelegate { }

extension SearchResultsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

class SearchResultsViewController: UIViewController { }

// MARK: Setup
extension NotesViewController {
    
    @objc func add(barButton: UIBarButtonItem) {
        let addNoteViewController = AddNoteViewController()
        navigationController?.pushViewController(addNoteViewController, animated: true)
    }
    
    func setupViewController() {
        view.backgroundColor = .white
        
        title = "Todo MVI"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(add(barButton:))
        )
        
        setupSearchController()
    }
    
    private func setupActivityIndicator() {
        tableView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    }
    
    private func setupSearchController () {
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            definesPresentationContext = true
        } else {
            definesPresentationContext = true
            tableView.tableHeaderView = searchController.searchBar
            navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    private func todoSearchController() -> UISearchController {
        let searchResultsViewController = SearchResultsViewController()
        let searchController = UISearchController(searchResultsController: searchResultsViewController)
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "SEARCH"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = searchResultsViewController
        return searchController
    }

}


