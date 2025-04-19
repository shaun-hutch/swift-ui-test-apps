//
//  Todo.swift
//  todolist
//
//  Created by Shaun Hutchinson on 14/04/2025.
//

import Foundation
import SwiftData

@Model
class Todo: Identifiable {
    @Attribute(.unique) var id: UUID
    var dueDate: Date?
    var lastModifiedDate: Date
    var text: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), dueDate: Date? = nil, lastModifiedDate: Date = Date(), text: String = "", isCompleted: Bool = false) {
        self.id = id
        self.dueDate = dueDate
        self.lastModifiedDate = lastModifiedDate
        self.text = text
        self.isCompleted = isCompleted
    }
        

    func toggle() {
        print("toggling")
        isCompleted.toggle()
    }
}

extension Todo {
    static var SampleData = [
        Todo(text: "test"),
        Todo(text: "test2"),
        Todo(text: "test3")
    ]
}
