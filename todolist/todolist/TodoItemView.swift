//
//  TodoItem.swift
//  todolist
//
//  Created by Shaun Hutchinson on 14/04/2025.
//

import SwiftUI

struct TodoItemView: View {
    // object passed from context which can be edited
    @Bindable var todoItem: Todo
    
    // pass a focus state from parent
    @FocusState.Binding var focusedID: UUID?
    
    // context to make changes
    @Environment(\.modelContext) var context
    
    var body: some View {
        HStack {
            toggleButton
            textField
            dateButton
        }
    }
    
    var textField: some View {
        TextField("Add Todo", text: $todoItem.text)
            .focused($focusedID, equals: todoItem.id)
            .submitLabel(.done)
            .onSubmit {
                focusedID = nil
            }
    }
    
    var toggleButton: some View {
        Button(action: {
            withAnimation {
                print("tapped toggle button")
                updateToggle()
            }
        }) {
            Image(systemName: todoItem.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title2)
        }
        .buttonStyle(.borderless)
    }
    
    var dateButton: some View {
        Button(action: {
            print("tapped date button")
        }) {
            Image(systemName: "bell")
                .font(.title2)
        }
        .buttonStyle(.borderless)
    }
    
    // todo date picker field (full or wheel?)
    
    private func updateToggle() {
        todoItem.isCompleted.toggle()
        todoItem.isCompletedInt = todoItem.isCompleted ? 1 : 0
        todoItem.updateLastModifiedDate()
        try? context.save()
    }
}

#Preview {
    struct PreviewWrapper: View {
        // mock data for preview (needed focus state declaration and view wrapper to preview correctly)
        @State private var todoItem = Todo(text: "Buy groceries")
        @FocusState private var focusedID: UUID?

        var body: some View {
            TodoItemView(todoItem: todoItem, focusedID: $focusedID)
        }
    }

    return PreviewWrapper()
        .modelContainer(for: Todo.self) // This adds an in-memory SwiftData context for previews
}
