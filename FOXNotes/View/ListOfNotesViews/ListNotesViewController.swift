//
//  ListNotesViewController.swift
//  FOXNotes
//
//  Created by Danil Lamonov on 13.05.2024.
//

import UIKit

protocol NewNoteViewControllerDelegate: AnyObject {
    func updateNote(_ note: Note)
    func deleteNote(_ note: Note)
}

class ListNotesViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countOfNotes: UILabel!
    
    var notes: [Note] = [] {
        didSet {
            countOfNotes.text = "\(notes.count) \(notes.count == 1 ? "Note" : "Notes")"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        notes = StorageManager.shared.fetchNote()
        notes = CoreDataManager.shared.fetchData()
        tableView.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        
    }
    
    @IBAction func newNoteButtonPressed(_ sender: Any) {
        editNote(createNote())
    }
    func createNote() -> Note {
        let note = CoreDataManager.shared.addNote()
        notes.insert(note, at: 0)
//        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        return note
    }
    func editNote(_ note: Note){
        guard let editNoteVC = storyboard?.instantiateViewController(identifier: "EditNoteViewController") as? EditNoteViewController else { return }
        editNoteVC.note = note
        editNoteVC.delegate = self
        show(editNoteVC, sender: nil)
    }
    private func deleteNoteFromStorage(_ note: Note) {
        deleteNote(note)
        CoreDataManager.shared.deleteNote(note)
    }
    private func indexForNote(id: UUID, in list: [Note]) -> IndexPath {
        let row = Int(list.firstIndex(where: { $0.id == id }) ?? 0)
        return IndexPath(row: row, section: 0)
    }
}
    // MARK: - UITAbleViewDataSource
extension ListNotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notePrototype", for: indexPath) as! NoteViewCell
        let note = notes[indexPath.row]
        cell.titleLabel.text = note.title
        cell.dateLabel.text = note.desc
        return cell
    }
}
    // MARK: - UITableViewDelegate
extension ListNotesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            deleteNoteFromStorage(notes[indexPath.row])
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        editNote(note)
    }
}
// MARK: - NewNoteViewControllerDelegate
extension ListNotesViewController: NewNoteViewControllerDelegate {
    func updateNote(_ note: Note) {
        let id = note.id
        let intId = Int(notes.firstIndex(where: { $0.id == id }) ?? 0)
        notes.remove(at: intId)
        notes.insert(note, at: intId)
        tableView.reloadData()
//        CoreDataManager.shared.addNote()
//        StorageManager.shared.addNote(with: note)
    }
    func deleteNote(_ note: Note){
        guard let id = note.id else {return}
        let indexPath = indexForNote(id: id, in: notes)
        notes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
//        CoreDataManager.shared.deleteNote(note)
//        StorageManager.shared.deleteNote(at: indexPath.row)
    }
}
