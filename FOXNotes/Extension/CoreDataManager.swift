//
//  CoreDataManager.swift
//  FOXNotes
//
//  Created by Danil Lamonov on 19.05.2024.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(){
        if context.hasChanges{
            do {
                try context.save()
            } catch let error{
                print(error)
            }
        }
    }
}
extension CoreDataManager{
    func addNote() -> Note {
        let note = Note(context: context)
        note.id = UUID()
        note.textOfNote = ""
        note.lastUpdate = Date()
        save()
        return note
    }
    func fetchData() -> [Note]{
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            let notes = try context.fetch(fetchRequest)
            return notes
        } catch let error {
            print(error)
        }
        return []
    }
    func deleteNote(_ note: Note) {
        context.delete(note)
        save()
    }
}
