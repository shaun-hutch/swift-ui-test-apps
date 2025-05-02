//
//  Todo.swift
//  todolist
//
//  Created by Shaun Hutchinson on 14/04/2025.
//

import Foundation
import SwiftData

@Model
final class Todo: Identifiable {
    @Attribute(.unique) var id: UUID
    var dueDate: Date?
    var lastModifiedDate: Date
    var text: String
    var isCompleted: Bool
    
    // property to sort boolean with
    var isCompletedInt: Int

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

extension Todo {
    static var SampleData = [
        Todo(dueDate: Date(timeIntervalSinceNow: 3600), text: "test"),
        Todo(dueDate: Date(), text: "test2"),
        Todo(dueDate: Date(), text: "test3")
    ]    
}
