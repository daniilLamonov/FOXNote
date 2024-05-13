//
//  Note+CoreDataClass.swift
//  FOXNotes
//
//  Created by Danil Lamonov on 20.05.2024.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    var title: String {
        return textOfNote.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? "" // returns the first line of the text
    }
    var desc: String {
        var lines = textOfNote.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        lines.removeFirst()
        return "\(lastUpdate.format()) \(lines.first ?? "")" // return second line
    }
}
