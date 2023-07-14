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
}

class MainDictionaryPresenter: MainDictionaryViewPresenter {
    weak var view: MainDictionaryView?
    
    private var items: [Word] = []
    
    init() {
        let word1 = Word(word: "cat", language: "", PartOfSpeech: "", transcription: "")
        word1.meaning = [Word(word: "кошка", language: "", PartOfSpeech: "", transcription: ""),
                         Word(word: "кот", language: "", PartOfSpeech: "", transcription: "")]
        items = [word1]
    }
    
    // MARK: Convert model form Core Data to UI
    func translateCoreToUI(coreWord: CoreWord) -> Word {
        var word: Word = Word(word: coreWord.word ?? "None",
                              language: coreWord.language,
                              PartOfSpeech: coreWord.partOfSpeech,
                              transcription: coreWord.transcription
        )
        
        if let meanings = coreWord.meanings?.allObjects as? [CoreMeaning] {
            word.meaning = meanings.map{ coreMeaning in
                Word(word: coreMeaning.word ?? "None",
                     language: coreMeaning.language,
                     PartOfSpeech: coreMeaning.partOfSpeech,
                     transcription: coreMeaning.transcription
                )
            }
        }
        
        
        return word
    }
    
    // MARK: - Private methods
    func retriveItems() {
        if let coreWords = CoreWordService.fetchCoreWords() {
            items = coreWords.map({ coreWord in
                translateCoreToUI(coreWord: coreWord)
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
//        items.remove(at: index)
        CoreWordService.deleteWord(word: word)
        view?.onItemDelete(index: index)
    }
}
