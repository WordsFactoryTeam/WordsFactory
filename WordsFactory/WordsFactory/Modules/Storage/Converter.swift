//
//  Converter.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 14.07.2023.
//

import Foundation


// Converts model form Core Data Models to UI Models
class Converter {
    static func translateCoreToUI(coreWord: CoreWord) -> Word {
        let word: Word = Word(word: coreWord.word ?? "None",
                              language: coreWord.language,
                              PartOfSpeech: coreWord.partOfSpeech,
                              transcription: coreWord.transcription
        )
        
        if let meanings = coreWord.meanings?.allObjects as? [CoreMeaning] {
            word.meaning = meanings.map { coreMeaning in
                Word(word: coreMeaning.word ?? "None",
                     language: coreMeaning.language,
                     PartOfSpeech: coreMeaning.partOfSpeech,
                     transcription: coreMeaning.transcription
                )
            }.sorted(by: { $0.word < $1.word })
        }
        return word
    }
    
    static func translateWordsCoresToUIs(coreWords: [CoreWord]?) -> [Word]? {
        guard let words = coreWords else { return nil }
        
        return words.map { coreWord in
            Converter.translateCoreToUI(coreWord: coreWord)
        }
    }
}
