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
            }
            .onAppear {
                if let initialDate {
                    selectedDate = initialDate
                }
            }
            .presentationDetents([.medium])
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            initialDate = selectedDate
                            print(initialDate?.formatted(date: .long, time: .omitted) ?? "No date")
                        }
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    TodoDatePicker(initialDate: .constant(Date()))
}
