//
//  CoreMeaning+CoreDataProperties.swift
//  
//
//  Created by Антон Нехаев on 14.07.2023.
//
//

import Foundation
import CoreData


extension CoreMeaning {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreMeaning> {
        return NSFetchRequest<CoreMeaning>(entityName: "CoreMeaning")
    }

    @NSManaged public var language: String?
    @NSManaged public var partOfSpeech: String?
    @NSManaged public var transcription: String?
    @NSManaged public var word: String?
    @NSManaged public var wordRef: CoreWord?

}
