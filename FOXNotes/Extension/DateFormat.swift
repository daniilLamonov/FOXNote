//
//  DateFormat.swift
//  FOXNotes
//
//  Created by Danil Lamonov on 22.05.2024.
//

import Foundation
extension Date {
    func format() -> String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(self) {
            formatter.dateFormat = "h:mm a"
            
        } else {
            formatter.dateFormat = "dd/MM/yy"
        }
        return formatter.string(from: self)
    }
}
