//
//  TodoItem.swift
//  todolist
//
//  Created by Shaun Hutchinson on 14/04/2025.
//

import SwiftUI

struct TodoItemView: View {
    @Bindable var todoItem: Todo
    @FocusState.Binding var focusedID: UUID?
    
    @Environment(\.modelContext) var context
    
    var body: some View {
        HStack {
            Button(action: {
                todoItem.toggle()
            }) {
                Image(systemName: todoItem.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    
            }
            
            TextField("Add Todo", text: $todoItem.text)
                .focused($focusedID, equals: todoItem.id)
                .submitLabel(.done)
                .onSubmit {
                    focusedID = nil
                }
        }
        .onChange(of: focusedID) { oldValue, newValue in
            if newValue == nil {
                do {
                    try context.save()
                } catch {
                    print("Failed to save changes: \(error)")
                }
            }
        }
    }
}
