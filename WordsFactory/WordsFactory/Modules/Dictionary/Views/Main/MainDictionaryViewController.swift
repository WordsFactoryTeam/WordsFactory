//
//  MainDictionary.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 03.07.2023.
//

import UIKit
import AVFAudio

protocol MainDictionaryView: AnyObject {
    func onItemsRetrieval(items: [Word])
    func onItemDelete(index: Int)
    func onItemSearch(items: [Word])
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
        table.separatorColor = .clear
        
        let cellNib = UINib(nibName: "WordTableViewCell", bundle: nil)
        table.register(cellNib, forCellReuseIdentifier: "WordTableViewCell")
        
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
    
    func onItemSearch(items: [Word]) {
        words = items
        tableOfWords.reloadData()
    }
}


extension MainDictionaryViewController: UITableViewDelegate {
    
//    func tableView(
//        _ tableView: UITableView,
//        shouldHighlightRowAt indexPath: IndexPath
//    ) -> Bool {
//        (tabBarController?.viewControllers?.last
//         as? MainSearchViewController)?.setInfo(word: words[indexPath.row])
//        tabBarController?.selectedIndex = 2
//        return false
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableOfWords.deselectRow(at: indexPath, animated: false)
        let destination = MainSearchViewController()
        destination.isFromDictionary = true
        destination.setInfo(word: words[indexPath.row])
            
        self.navigationController?.pushViewController(destination, animated: true)
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
        } else {
            tableView.removeEmptyDataView()
        }
        
        return words.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "WordTableViewCell",
            for: indexPath
        ) as! WordTableViewCell
                
        
        cell.setDictionaryInfo(info: words[indexPath.row])
        cell.selectionStyle = .none
        
        cell.speakButton.removeTarget(nil, action: nil, for: .allEvents)
        cell.speakButton.addAction(UIAction(handler: { _ in
            let wordSpeak = self.words[indexPath.row]
            let utterance = AVSpeechUtterance(string: wordSpeak.word)
            utterance.voice = AVSpeechSynthesisVoice(language: wordSpeak.language )
            utterance.rate = 0.1
            
            let synthesizer = AVSpeechSynthesizer()
            if !synthesizer.isSpeaking{
                synthesizer.speak(utterance)
            }
        }), for: .touchUpInside)
        
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
        
        presenter?.searchForWord(literalWord: text)
    }
}
