//
//  DateExtensions.swift
//  todolist
//
//  Created by Shaun Hutchinson on 18/05/2025.
//

import Foundation

extension Date {
    static func todayAt(hour: Int = 0, minute: Int = 0) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components) ?? Date()
    }
}
