//
//  MainTrainingPresenter.swift.swift
//  WordsFactory
//
//  Created by Алёна Максимова on 13.07.2023.
//

import Foundation

protocol MainTrainingViewPresenter {
    init(view: MainTrainingView)
    func viewDidLoad()
    //func deleteWord(for index: Int)
}

class MainTrainingPresenter: MainTrainingViewPresenter {
    weak var view: MainTrainingView?
    private var items: [Word] = []
    
    // MARK: - Private methods
    func retriveItems() {
        let coreWords = CoreWordService.fetchCoreWords()
        items = Converter.translateWordsCoresToUIs(coreWords: coreWords) ?? []
        view?.onItemsRetrieval(items: items)
    }
    
    
    
    // MARK: - Protocol methods
    required init(view: MainTrainingView) {
        self.view = view
    }
    
    func viewDidLoad() {
        retriveItems()
    }
    
}

