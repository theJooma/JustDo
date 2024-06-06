//
//  Items+CoreDataProperties.swift
//  JustDo
//
//  Created by Jumageldi on 6.06.2024.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var done: Bool
    @NSManaged public var title: String?

}

extension Items : Identifiable {

}
