//
//  Categori+CoreDataProperties.swift
//  JustDo
//
//  Created by Jumageldi on 7.06.2024.
//
//

import Foundation
import CoreData


extension Categori {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categori> {
        return NSFetchRequest<Categori>(entityName: "Categori")
    }

    @NSManaged public var name: String?
    @NSManaged public var emoji: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Categori {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Items)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Items)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension Categori : Identifiable {

}
