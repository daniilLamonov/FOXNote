//
//  Note+CoreDataProperties.swift
//  FOXNotes
//
//  Created by Danil Lamonov on 20.05.2024.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID!
    @NSManaged public var textOfNote: String!
    @NSManaged public var lastUpdate: Date!

}

extension Note : Identifiable {

}
