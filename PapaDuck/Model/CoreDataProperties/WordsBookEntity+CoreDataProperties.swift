//
//  WordsBookEntity+CoreDataProperties.swift
//  PapaDuck
//
//  Created by 백시훈 on 8/13/24.
//
//

import Foundation
import CoreData


extension WordsBookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordsBookEntity> {
        return NSFetchRequest<WordsBookEntity>(entityName: "WordsBookEntity")
    }

    @NSManaged public var wordsBookId: UUID?
    @NSManaged public var wordsBookName: String?
    @NSManaged public var wordsExplain: String?
    @NSManaged public var wordsBooks: WordsEntity?

}

extension WordsBookEntity : Identifiable {

}
