//
//  Word.swift
//  WordsFactory
//
//  Created by SHREDDING on 12.07.2023.
//

import Foundation

class Word{

    let word:String
    let language:String?
    let PartOfSpeech:String?
    let transcription:String?
    
    var meaning:[Word] = []
    
    
    init(word: String,language:String?, PartOfSpeech: String?, transcription: String?) {
        self.word = word
        self.language = language
        self.PartOfSpeech = PartOfSpeech
        self.transcription = transcription
    }
    
    
    public func printWord(){
        print(word)
        print(PartOfSpeech)
        print(transcription)
        
        for i in meaning{
            i.printWord()
        }
    }
}
