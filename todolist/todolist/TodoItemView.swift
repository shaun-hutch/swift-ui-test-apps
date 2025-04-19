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
    
    @State private var pickerDate: Date? = nil
    @State private var isShowingDatePicker = false
    
    var body: some View {
        VStack {
            HStack {
                toggleButton
                textField
                datePickerButton
            }
            .onChange(of: focusedID) { _, newValue in
                focusChangeHandler(newValue: newValue)
            }
            
            if isShowingDatePicker {
                datePicker
            }
        }
        
        
    }
    
    var toggleButton: some View {
        Button(action: {
            todoItem.toggle()
        }) {
            Image(systemName: todoItem.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title2)
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
    
    var datePickerButton: some View {
        VStack(alignment: .leading) {
                Button {
                    withAnimation {
                        isShowingDatePicker.toggle()
                    }
                } label: {
                    HStack {
                        if let pickerDate {
                            withAnimation {
                                Text("Due: \(pickerDate.formatted(.dateTime.month(.abbreviated).day()))")
                            }
                        } else {
                            Image(systemName: "calendar")
                                .foregroundStyle(.blue)
                        }
                    }
                }
            }
            .padding()
    }
    
    var datePicker: some View {
        DatePicker(
            "",
            selection: Binding(
                get: { pickerDate ?? Date() },
                set: { date in
                    withAnimation {
                        pickerDate = date
                        isShowingDatePicker.toggle()
                    }

                }
            ),
            displayedComponents: [.date],
            
        )
        .datePickerStyle(.graphical)
        .padding(5)
        
    }
    
    // save on focus loss
    private func focusChangeHandler(newValue: UUID?) {
        if newValue == nil {
            do {
                // update last modified
                todoItem.lastModifiedDate = Date()
                
                try context.save()
            } catch {
                print("Failed to save changes: \(error)")
            }
        }
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
