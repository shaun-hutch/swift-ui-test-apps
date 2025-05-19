//
//  TodoDatePicker.swift
//  todolist
//
//  Created by Shaun Hutchinson on 29/04/2025.
//

import SwiftUI

struct TodoDateTimePicker: View {
    
    // value from the todo data
    @Binding var initialDateTime: Date?
    
    @State private var selectedDateTime: Date = Date.todayAt(hour: 12)
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                cancelButton
                Spacer()
                saveButton
            }
            .padding()
            DatePicker("", selection: $selectedDateTime, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.graphical)
            if initialDateTime != nil {
                clearButton
            }
        }
        .presentationDetents([.height(550)])
        .onAppear {
            if let initialDateTime {
                selectedDateTime = initialDateTime
            }
        }
        
        // have this set for only pickers on this view, otherwise the entire app would have this as its interval
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 5
        }
        .onDisappear {
            UIDatePicker.appearance().minuteInterval = 1
        }
    }
    
    var clearButton: some View {
        Button(action: {
            withAnimation {
                initialDateTime = nil
                dismiss()
            }
        }) {
            Image(systemName: "calendar.badge.minus")
            Text("Remove")
        }
        .padding(8)
        .background(Color.red.opacity(0.1))
        .foregroundColor(.red)
        .clipShape(Capsule())
    }
    
    var saveButton: some View {
        Button(action: {
            withAnimation {
                initialDateTime = selectedDateTime
                
                
                
                
                dismiss()
            }
        }) {
            HStack(alignment: .center) {
                Image(systemName: "calendar.badge.plus")
                Text("Save")
            }
        }
        .padding(8)
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
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .foregroundColor(.gray)
        .clipShape(Capsule())
    }
}

#Preview {
    TodoDateTimePicker(initialDateTime: .constant(nil))
}
