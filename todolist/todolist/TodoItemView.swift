//
//  TodoItem.swift
//  todolist
//
//  Created by Shaun Hutchinson on 14/04/2025.
//

import SwiftUI

struct TodoItemView: View {
    @Binding var todoItem: Todo
    @FocusState private var textFieldfocused: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                todoItem.toggle()
            }) {
                Image(systemName: todoItem.isCompleted ? "circle" : "checkmark.circle.fill")
                    .font(.title2)
                    
            }
            
            TextField("Add Todo", text: $todoItem.text)
                .focused($textFieldfocused)
                .submitLabel(.done)
                .onSubmit {
                    textFieldfocused = false
                }
        }
    }
}

#Preview {
    TodoItemView(todoItem: .constant(Todo.SampleData[0]))
}
