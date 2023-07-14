//
//  CoreWordService.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 13.07.2023.
//

import UIKit
import Foundation
import CoreData


class CoreWordService {
    static func fetchCoreWords() -> [CoreWord]? {
        let fetchRequest: NSFetchRequest<CoreWord> = CoreWord.fetchRequest()
        fetchRequest.sortDescriptors = [
            .init(key: "word", ascending: true)
        ]
    
        do {
            let coreWords = try PersistentContainer.shared.viewContext.fetch(fetchRequest)
            return coreWords
        } catch {
            print("Error fetching Core Words: \(error)")
            return nil
        }
    }
    
    static func filterWords(literalWord: String) -> [CoreWord]? {
        let fetchRequest: NSFetchRequest<CoreWord> = CoreWord.fetchRequest()
        fetchRequest.sortDescriptors = [
            .init(key: "word", ascending: true)
        ]
        let coreWordPredicate = NSPredicate(format: "word CONTAINS[cd] %@", literalWord)
        let coreMeaningPredicate = NSPredicate(format: "ANY meanings.word CONTAINS[cd] %@", literalWord)
        
        let compountPredicate = NSCompoundPredicate(
            orPredicateWithSubpredicates: [coreWordPredicate, coreMeaningPredicate]
        )
        fetchRequest.predicate = compountPredicate
        
        do {
            let coreWordsThatMachesPredicate = try PersistentContainer.shared.viewContext.fetch(fetchRequest)
            return coreWordsThatMachesPredicate
        } catch {
            print("Error filterring words")
            return nil
        }
    }

    static func createCoreWord(word: Word?) {
        guard let word else { return }
        PersistentContainer.shared.performBackgroundTask { backgroundContext in
            let coreWord = CoreWord(context: backgroundContext)
            coreWord.word = word.word
            coreWord.language = word.language
            coreWord.partOfSpeech = word.PartOfSpeech
            coreWord.transcription = word.transcription
            
            word.meaning.forEach { mean in
                let newMeaning = CoreMeaning(context: backgroundContext)
                newMeaning.wordRef = coreWord
                newMeaning.word = mean.word
                newMeaning.language = mean.language
                newMeaning.transcription = mean.transcription
                newMeaning.partOfSpeech = mean.PartOfSpeech
                
                coreWord.addToMeanings(newMeaning)
            }

            PersistentContainer.shared.saveContext(backgroundContext: backgroundContext)
        }
    }
    
    static func deleteWord(word: Word?) {
        guard let word else { return }
        
        PersistentContainer.shared.performBackgroundTask { backGroudContext in
            let fetchRequest: NSFetchRequest<CoreWord> = CoreWord.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "word == %@", word.word)
            
            do {
                let coreWords = try backGroudContext.fetch(fetchRequest)
                coreWords.forEach { coreWord in
                    backGroudContext.delete(coreWord)
                }
                PersistentContainer.shared.saveContext(backgroundContext: backGroudContext)
            } catch {
                print("Error fetching Core Words: \(error)")
                return
            }
        }
    }
}
