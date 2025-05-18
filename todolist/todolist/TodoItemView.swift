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
    
    @State private var datePickerOpened = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                toggleButton
                textField
                Spacer()
                dateButton
            }
            .padding(.top, 4)
        }
        .sheet(isPresented: $datePickerOpened) {
            TodoDateTimePicker(initialDateTime: $todoItem.dueDate)
        }
        .onChange(of: datePickerOpened) {
            if (datePickerOpened == false) {
                withAnimation {
                    todoItem.updateLastModifiedDate()
                }
            }
        }
        .listRowSeparator(.hidden)
    }
    
    var textField: some View {
        TextField("Add Todo", text: $todoItem.text, axis: .vertical)
            .focused($focusedID, equals: todoItem.id)
            .onSubmit {
                focusedID = nil
            }
    }
    
    var toggleButton: some View {
        Button(action: {
            withAnimation {
                updateToggle()
            }
        }) {
            Image(systemName: todoItem.isCompleted ? "checkmark.circle.fill" : "circle")
        }
        // this confines the tappable bounds of the button so they can be individually tapped in a list item
        .buttonStyle(.borderless)
    }
    
    var dateButton: some View {
        Button(action: {
            datePickerOpened.toggle()
        }) {
            Text(todoItem.dueDate?.formatted(Date.FormatStyle.dateTime.hour().minute() .day().month()) ?? "")
                .font(.footnote)
            Image(systemName: todoItem.dueDate != nil ? "bell.badge.fill" : "bell")
        }
        .foregroundStyle(todoItem.priorityColor)
        .buttonStyle(.borderless)
    }
    
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
        @State private var todoItem = Todo(dueDate: Date(), text: "Buy groceries")
        @FocusState private var focusedID: UUID?

        var body: some View {
            TodoItemView(todoItem: todoItem, focusedID: $focusedID)
        }
    }

    return PreviewWrapper()
        .modelContainer(for: Todo.self)  // This adds an in-memory SwiftData context for previews
        .padding()
}
