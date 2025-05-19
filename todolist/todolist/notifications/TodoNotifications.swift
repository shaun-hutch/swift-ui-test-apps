//
//  TodoNotifications.swift
//  todolist
//
//  Created by Shaun Hutchinson on 18/05/2025.
//

import UserNotifications

func requestNotificationPermissions() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
        if success {
            
        } else if let error {
            print(error.localizedDescription)
        }
    }
}

func scheduleNotification(for todo: Todo) {
    guard let date = todo.dueDate else { return }
    
    let content = UNMutableNotificationContent()
    
    content.title = todo.text
    content.subtitle = "Due: \(todo.formattedDueDate)"
    content.sound = .default
    
    
    let dueDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
    let oneHourReminderComponents = Calendar.current.date(byAdding: .hour, value: -1, to: date)
    
    // set a notification 1 hour before then on the due date
    let dueDateTrigger = UNCalendarNotificationTrigger(dateMatching: dueDateComponents, repeats: false)
    let oneHourReminderTrigger = UNCalendarNotificationTrigger(dateMatching: dueDateComponents, repeats: false)
    
    let dueDateRequest = UNNotificationRequest(identifier: todo.id.uuidString, content: content, trigger: dueDateTrigger)
    let oneHourReminderRequest = UNNotificationRequest(identifier: todo.id.uuidString, content: content, trigger: oneHourReminderTrigger)
    
    UNUserNotificationCenter.current().add(dueDateRequest) { error in
        if let error = error {
            print("Error scheduling notification: \(error)")
        }
    }
    
    UNUserNotificationCenter.current().add(oneHourReminderRequest) { error in
        if let error = error {
            print("Error scheduling notification: \(error)")
        }
    }
}


func cancelNotification(id: UUID) {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
}
