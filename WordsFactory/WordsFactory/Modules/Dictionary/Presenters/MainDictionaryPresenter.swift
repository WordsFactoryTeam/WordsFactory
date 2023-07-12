//
//  MainDictionaryPresenter.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 04.07.2023.
//

import Foundation

protocol MainDictionaryViewPresenter {
    init(view: MainDictionaryView)
    func viewDidLoad()
    func deleteWord(for index: Int)
}

class MainDictionaryPresenter: MainDictionaryViewPresenter {
    weak var view: MainDictionaryView?
//    private var items = [UIWord]()
    private var items = [
        UIWord(wordOriginal: "Dog", wordTranslations: ["Собака"]),
        UIWord(wordOriginal: "Cat", wordTranslations: ["Кошка", "Кот", "Котенок"])
    ]
    
    
    // MARK: - Private methods
    func retriveItems() {
//        items =
        view?.onItemsRetrieval(items: items)
    }
    
    
    
    // MARK: - Protocol methods
    required init(view: MainDictionaryView) {
        self.view = view
    }
    
    func viewDidLoad() {
        retriveItems()
    }
    
    func deleteWord(for index: Int) {
        print(index)
        items.remove(at: index)
        view?.onItemDelete(index: index)
    }
}
