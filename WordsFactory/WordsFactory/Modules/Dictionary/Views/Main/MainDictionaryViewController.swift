//
//  MainDictionary.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 03.07.2023.
//

import UIKit

protocol MainDictionaryView: AnyObject {
    func onItemsRetrieval(items: [Word])
    func onItemDelete(index: Int)
}

final class MainDictionaryViewController: UIViewController {
    private var words = [Word]()
    var presenter: MainDictionaryViewPresenter!
    
    private let searchController: UISearchController = {
        var searchController = UISearchController(searchResultsController: nil)
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        return searchController
    }()
    
    private lazy var tableOfWords: UITableView = {
        var table = DynamicTable()
        table.register(DynamicTableCell.self, forCellReuseIdentifier: DynamicTableCell.reuseIdentifier)
        //        table.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = UIColor(named: "BackgroundColor")
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableOfWords.dataSource = self
        tableOfWords.delegate = self
        
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        view.addSubview(tableOfWords)
        NSLayoutConstraint.activate(staticConstraints())
        
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewDidLoad()
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            tableOfWords.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableOfWords.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableOfWords.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableOfWords.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return constraints
    }
    
}

// MARK: - Protocol implementation
extension MainDictionaryViewController: MainDictionaryView {
    func onItemDelete(index: Int) {
        words.remove(at: index)
        let index = IndexPath(row: index, section: 0)
        tableOfWords.deleteRows(at: [index], with: .automatic)
    }
    
    func onItemsRetrieval(items: [Word]) {
        words = items
        tableOfWords.reloadData()
    }
}


extension MainDictionaryViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        shouldHighlightRowAt indexPath: IndexPath
    ) -> Bool {
        false
    }
    
}

extension MainDictionaryViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if words.isEmpty {
            tableView.setEmptyDataView(
                image: UIImage(named: "NoResultsImage") ?? UIImage(systemName: "book")!,
                title: "Someone stole your words!"
            )
            searchController.searchBar.isHidden = true
        } else {
            tableView.removeEmptyDataView()
            searchController.searchBar.isHidden = false
        }
        
        return words.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DynamicTableCell.reuseIdentifier,
            for: indexPath
        ) as? DynamicTableCell else { return UITableViewCell() }
        
        cell.setInfo(info: words[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
            self?.presenter.deleteWord(at: indexPath.row, for: self!.words[indexPath.row])
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}


extension MainDictionaryViewController: UISearchControllerDelegate {
    
}

extension MainDictionaryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}
