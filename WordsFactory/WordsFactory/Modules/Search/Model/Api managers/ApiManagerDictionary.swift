//
//  ApiManagerDictionary.swift
//  WordsFactory
//
//  Created by SHREDDING on 12.07.2023.
//

import Foundation
import Alamofire

class ApiManagerDictionary{
    
    enum possibleTranslateLanguages:String{
        case ruen = "ru-en"
        case enru = "en-ru"
        
        public func getSpeakLanguage()->String{
            switch self {
            case .ruen:
                return "ru-Ru"
            case .enru:
                return "en-US"
            }
        }
    }
    
    let baseUrlString = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?"
    
    let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
        
    
    public func getWord(word:String, completion: @escaping (Word?)->Void){
        
        let language = self.determineLanguage(word: word)
        
        let fullUrlString = "\(baseUrlString)key=\( apiKey)&lang=\(language.rawValue)&text=\(word)"
        
        let url = URL(string: fullUrlString)
        
        print(fullUrlString)
        
        AF.request(url!, method: .get).response { response in
            
            switch response.result {
            case .success(_):
                if response.response?.statusCode == 200{
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String:Any]

                        let word = self.parseJson(parsedData, lang: language)
                        completion(word)
                        
                    } catch let error as NSError {
                        print(error)
                        completion(nil)
                    }
                }else{
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
        
    }
    
    private func determineLanguage(word:String)->possibleTranslateLanguages{
        let englishLetters = "qwertyuiopasdfghjklzxcvbnm"
        
        if englishLetters.contains(word.lowercased().first ?? "n"){
            return .enru
        }else{
            return .ruen
        }
    }
    
    private func parseJson(_ json:[String:Any], lang:possibleTranslateLanguages)->Word?{
        
        let def = json["def"] as! NSArray
        if def.count == 0{
            return nil
        }
        let word = def[0] as! [String:Any]
        
        
        
        let wordText = word["text"] as! String
        let wordTs = word["ts"] as? String
        let wordPos = word["pos"] as? String
        
        let wordEntity = Word(word: wordText, language: lang.getSpeakLanguage(), PartOfSpeech: wordPos, transcription: wordTs)
        
        let tr = word["tr"] as? NSArray
                
        for i in tr ?? []{
            let element = i as! [String:Any]
            
            let elementText = element["text"] as! String
            let elementTs = element["ts"] as? String
            let elementPos = element["pos"] as? String
            
            let elementEntity = Word(word: elementText, language: nil, PartOfSpeech: elementPos, transcription: elementTs)
            
            wordEntity.meaning.append(elementEntity)
        }
        
        return wordEntity
    }
    
}
