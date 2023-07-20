//
//  CoreWord+CoreDataProperties.swift
//  
//
//  Created by Антон Нехаев on 14.07.2023.
//
//

import Foundation
import CoreData


extension CoreWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreWord> {
        return NSFetchRequest<CoreWord>(entityName: "CoreWord")
    }

    @NSManaged public var language: String?
    @NSManaged public var partOfSpeech: String?
    @NSManaged public var transcription: String?
    @NSManaged public var word: String?
    @NSManaged public var meanings: NSSet?

}

// MARK: Generated accessors for meanings
extension CoreWord {

    @objc(addMeaningsObject:)
    @NSManaged public func addToMeanings(_ value: CoreMeaning)

    @objc(removeMeaningsObject:)
    @NSManaged public func removeFromMeanings(_ value: CoreMeaning)

    @objc(addMeanings:)
    @NSManaged public func addToMeanings(_ values: NSSet)

    @objc(removeMeanings:)
    @NSManaged public func removeFromMeanings(_ values: NSSet)

}
