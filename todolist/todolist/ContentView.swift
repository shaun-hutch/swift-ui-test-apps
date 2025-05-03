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
    @Query(filter: #Predicate<Todo> { todo in
        todo.isCompleted == false
    }, sort: [
        SortDescriptor(\Todo.dueDate, order: .forward),
    ]) var incompleteTodos: [Todo]
    
    @Query(filter: #Predicate<Todo> { todo in
        todo.isCompleted
    }, sort: [
        SortDescriptor(\Todo.dueDate, order: .forward),
    ]) var completedTodos: [Todo]
    
    
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
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusedUUID = nil
                    }
                }
            }
        }
        
        
    }
    
    var list: some View {
        List {
            Section(header: Text("Completed")) {
                ForEach(completedTodos) { item in
                    TodoItemView(todoItem: item, focusedID: $focusedUUID)
                }
                .onDelete { indexSet in
                    deleteTodo(set: indexSet, todos: completedTodos)
                }
            }
            Section(header: Text("Incomplete")) {
                ForEach(incompleteTodos) { item in
                    TodoItemView(todoItem: item, focusedID: $focusedUUID)
                }
                .onDelete { indexSet in
                    deleteTodo(set: indexSet, todos: incompleteTodos)
                }
            }
            Section(header: Text("")) {
                addButton
            }
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
    
    private func deleteTodo(set: IndexSet, todos: [Todo]) {
        for index in set {
            let todoToDelete = todos[index]
            context.delete(todoToDelete)
        }
    }
    
    // save on focus loss
    private func focusChangeHandler(oldValue: UUID?, newValue: UUID?) {
        print("focus handler")
        
        // update the previous todo last modified date on focus loss
        if let oldValue {
            let todoToSave = (incompleteTodos + completedTodos).first { $0.id == oldValue }
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
