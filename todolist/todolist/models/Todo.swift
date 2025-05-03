//
//  Todo.swift
//  todolist
//
//  Created by Shaun Hutchinson on 14/04/2025.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Todo: Identifiable {
    @Attribute(.unique) var id: UUID
    var dueDate: Date?
    var lastModifiedDate: Date
    var text: String
    var isCompleted: Bool
    
    // property to sort boolean with
    var isCompletedInt: Int
    
    @Transient
    var priorityColor: Color {
        switch priority {
        case .high:
            return .red
        case .medium:
            return .orange
        case .low:
            return .green
        }
    }
    
    @Transient
    var priority: TodoPriority {
        guard let date = self.dueDate else {
            return .low
        }
        
        let now = Date()
        guard let oneWeekFromNow = Calendar.current.date(byAdding: .day, value: 7, to: now) else {
            return .low
        }
        
        if date > oneWeekFromNow {
            return .low
        } else if date >= now && date <= oneWeekFromNow {
            return .medium
        } else {
            return .high
        }
    }

    func updateLastModifiedDate() {
        lastModifiedDate = Date()
    }
    
    init(id: UUID = UUID(), dueDate: Date? = nil, lastModifiedDate: Date = Date(), text: String = "", isCompleted: Bool = false, isCompletedInt: Int = 0) {
        self.id = id
        self.dueDate = dueDate
        self.lastModifiedDate = lastModifiedDate
        self.text = text
        self.isCompleted = isCompleted
        self.isCompletedInt = isCompleted ? 1 : 0
    }
}

enum TodoPriority: String, CaseIterable {
    case high = "high"
    case medium = "medium"
    case low = "low"
}

extension Todo {
    static var SampleData = [
        Todo(dueDate: Date(timeIntervalSinceNow: 3600), text: "test"),
        Todo(dueDate: Date(), text: "test2"),
        Todo(dueDate: Date(), text: "test3")
    ]
}
