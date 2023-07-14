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
    func deleteWord(at index: Int, for word: Word)
    func searchForWord(literalWord: String)
}

class MainDictionaryPresenter: MainDictionaryViewPresenter {
    weak var view: MainDictionaryView?
    
    private var items: [Word] = []
    
    // MARK: - Private methods
    func retriveItems() {
        if let coreWords = CoreWordService.fetchCoreWords() {
            items = coreWords.map({ coreWord in
                Converter.translateCoreToUI(coreWord: coreWord)
            })
        }
        view?.onItemsRetrieval(items: items)
    }
    
    
    // MARK: - Protocol methods
    required init(view: MainDictionaryView) {
        self.view = view
    }
    
    func viewDidLoad() {
        retriveItems()
    }
    
    func deleteWord(at index: Int, for word: Word) {
        CoreWordService.deleteWord(word: word)
        view?.onItemDelete(index: index)
    }
    
    func searchForWord(literalWord: String) {
        let coreWords = literalWord.isEmpty ?
            CoreWordService.fetchCoreWords():
            CoreWordService.filterWords(literalWord: literalWord)
        items = Converter.translateWordsCoresToUIs(coreWords: coreWords) ?? []
        view?.onItemSearch(items: items)
    }
}
