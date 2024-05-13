//
//  EditNoteViewController.swift
//  FOXNotes
//
//  Created by Danil Lamonov on 13.05.2024.
//

import UIKit


class EditNoteViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: NewNoteViewControllerDelegate!
    var note: Note!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = note?.textOfNote
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    private func deleteNote() {
        delegate.deleteNote(note)
        CoreDataManager.shared.deleteNote(note)
    }
    private func saveNote() {
        note.lastUpdate = Date()
        delegate.updateNote(note)
        CoreDataManager.shared.save()
    }
}
extension EditNoteViewController: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.textOfNote = textView.text
        guard let textNote = note.textOfNote else { return }
        if textNote.isEmpty {
            deleteNote()
        } else {
            saveNote()
        }
    }
}
