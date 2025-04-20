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
        SortDescriptor(\Todo.isCompletedInt, order: .reverse),
        SortDescriptor(\Todo.lastModifiedDate, order: .reverse),
    ]) var todos: [Todo]
    @FocusState private var focusedUUID: UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                list
            }
            .onChange(of: focusedUUID) { oldValue, newValue in
                withAnimation {
                    focusChangeHandler(oldValue: oldValue, newValue: newValue)
                }

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
    
    // save on focus loss
    private func focusChangeHandler(oldValue: UUID?, newValue: UUID?) {
        print("focus handler")
        
        // update the previous todo last modified date on focus loss
        if let oldValue {
            let todoToSave = todos.first { $0.id == oldValue }
            if let todoToSave {
                print("updating last modified")
                todoToSave.updateLastModifiedDate()
            }
        }

        do {
            try context.save()
        } catch {
            print("Failed to save changes: \(error)")
        }
        
    }
}

#Preview {
    ContentView()
}
