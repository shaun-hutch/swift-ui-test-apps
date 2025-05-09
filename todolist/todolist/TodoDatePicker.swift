//
//  TodoDatePicker.swift
//  todolist
//
//  Created by Shaun Hutchinson on 29/04/2025.
//

import SwiftUI

struct TodoDatePicker: View {
    
    // value from the todo data
    @Binding var initialDate: Date?
    
    @State private var selectedDate: Date = Date()
    
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                if initialDate != nil {
                    clearButton
                }
            }
            .onAppear {
                if let initialDate {
                    selectedDate = initialDate
                }
            }
            .presentationDetents([.medium])
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    saveButton
                }
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton
                }
            }
        }
        .background(.ultraThinMaterial)
    }
    
    var clearButton: some View {
        Button(action: {
            withAnimation {
                initialDate = nil
                dismiss()
            }
        }) {
            Image(systemName: "calendar.badge.minus")
            Text("Remove")
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        .background(Color.red.opacity(0.1))
        .foregroundColor(.red)
        .clipShape(Capsule())
    }
    
    var saveButton: some View {
        Button(action: {
            withAnimation {
                initialDate = selectedDate
                dismiss()
            }
        }) {
            HStack(alignment: .center) {
                Image(systemName: "calendar.badge.plus")
                Text("Save")
            }
        }
        .padding(.vertical, 4)
        .padding(.trailing, 8)
        .background(Color.green.opacity(0.1))
        .foregroundColor(.green)
        .clipShape(Capsule())
    }
    
    var cancelButton: some View {
        Button(action: {
            withAnimation {
                dismiss()
            }
        }) {
            Image(systemName: "xmark.app")
            Text("Cancel")
        }
        .padding(.vertical, 4)
        .padding(.leading, 6)
        .background(Color.gray.opacity(0.1))
        .foregroundColor(.gray)
        .clipShape(Capsule())
    }
}

#Preview {
    TodoDatePicker(initialDate: .constant(Date()))
}
