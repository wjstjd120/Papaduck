//
//  UserEntity+CoreDataProperties.swift
//  PapaDuck
//
//  Created by 백시훈 on 8/13/24.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var exp: String?

}

extension UserEntity : Identifiable {

}
