//
//  Language.swift
//  WordsFactory
//
//  Created by SHREDDING on 20.07.2023.
//

import Foundation



public enum possibleTranslateLanguages:String {
    case ruen = "ru-en"
    case enru = "en-ru"
    
    public func getSpeakLanguage() -> String {
        switch self {
        case .ruen:
            return "ru-Ru"
        case .enru:
            return "en-US"
        }
    }
}


class Language{
    
    static public func determineLanguage(word: String) -> possibleTranslateLanguages {
        let englishLetters = "qwertyuiopasdfghjklzxcvbnm"
        
        if englishLetters.contains(word.lowercased().first ?? "n"){
            return .enru
        } else {
            return .ruen
        }
    }
}
