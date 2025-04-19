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
    var date: Date
    var text: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), date: Date = Date(), text: String, isCompleted: Bool = false) {
        self.id = id
        self.date = date
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
        Todo(text: "test", isCompleted: false),
        Todo(text: "test2", isCompleted: true),
        Todo(text: "test3", isCompleted: false)
    ]
}
