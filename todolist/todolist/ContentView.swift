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
    @Query(sort: [
        SortDescriptor(\Todo.dueDate, order: .reverse),
        SortDescriptor(\Todo.lastModifiedDate, order: .reverse)
    ]) var todos: [Todo]
    @FocusState private var focusedUUID: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                list
            }
            .navigationTitle("Todo List")
        }
    }
    
    var list: some View {
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
            addButton
        }
    }
    
    var addButton: some View {
        Button("Add Todo") {
            withAnimation {
                createTodo()
            }
        }
    }
    
    private func createTodo() {
        let newTodo = Todo()
        do {
            context.insert(newTodo)
            try context.save()
            
            // set focus to newly created item, pop up keyboard in TodoItemView
            focusedUUID = newTodo.id
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
