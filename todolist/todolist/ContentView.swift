//
//  ContentView.swift
//  todolist
//
//  Created by Shaun Hutchinson on 14/04/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Todo.date) var todos: [Todo]
    @FocusState private var focusedUUID: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(todos) { item in
                        TodoItemView(todoItem: item, focusedID: $focusedUUID)
                       
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let todoToDelete = todos[index]
                            context.delete(todoToDelete)
                        }
                    }
                    Button("Add Todo") {
                        withAnimation {
                            let newTodo = Todo(text: "")
                            do {
                                context.insert(newTodo)
                                print("todo id: \(newTodo.id)")
                                try context.save()
                                focusedUUID = newTodo.id
                            } catch {
                                print("Failed to save context: \(error)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Todo List")
        }
    }
}

#Preview {
    ContentView()
}
