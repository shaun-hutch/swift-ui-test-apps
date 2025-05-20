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

func scheduleNotifications(for todo: Todo) {
    guard let date = todo.dueDate else { return }
    
    let content = UNMutableNotificationContent()
    
    content.title = todo.text
    content.subtitle = "Due: \(todo.formattedDueDate)"
    content.sound = .default
    
    let oneHourContent = UNMutableNotificationContent()
    oneHourContent.title = todo.text
    oneHourContent.subtitle = "Due at: \(todo.formattedDueDate)"
    oneHourContent.sound = .default
    
    // extract out the date into components
    let dueDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
    
    // subtract 1 hour from the date
    guard let oneHourReminderDate = Calendar.current.date(byAdding: .hour, value: -1, to: date) else { return }
    let oneHourReminderDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: oneHourReminderDate)
    
    // set a notification 1 hour before then on the due date
    let dueDateTrigger = UNCalendarNotificationTrigger(dateMatching: dueDateComponents, repeats: false)
    let oneHourReminderTrigger = UNCalendarNotificationTrigger(dateMatching: oneHourReminderDateComponents, repeats: false)
    
    let dueDateRequest = UNNotificationRequest(identifier: todo.id.uuidString, content: content, trigger: dueDateTrigger)
    let oneHourReminderRequest = UNNotificationRequest(identifier: "\(todo.id.uuidString)_oneHour", content: oneHourContent, trigger: oneHourReminderTrigger)
    
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


func cancelNotifications(ids: [String]) {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
}
