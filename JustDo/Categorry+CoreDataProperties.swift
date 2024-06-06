//
//  Categorry+CoreDataProperties.swift
//  JustDo
//
//  Created by Jumageldi on 6.06.2024.
//
//

import Foundation
import CoreData


extension Categorry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categorry> {
        return NSFetchRequest<Categorry>(entityName: "Categorry")
    }

    @NSManaged public var name: String?
    @NSManaged public var items: Items?

}

extension Categorry : Identifiable {

}
