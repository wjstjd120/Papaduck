//
//  WordsEntity+CoreDataProperties.swift
//  PapaDuck
//
//  Created by 백시훈 on 8/13/24.
//
//

import Foundation
import CoreData


extension WordsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordsEntity> {
        return NSFetchRequest<WordsEntity>(entityName: "WordsEntity")
    }

    @NSManaged public var wordsBookId: UUID?
    @NSManaged public var word: String?
    @NSManaged public var meaning: String?
    @NSManaged public var memorizationYn: Bool

}

extension WordsEntity : Identifiable {

}
