//
//  todolistApp.swift
//  todolist
//
//  Created by Shaun Hutchinson on 14/04/2025.
//

import SwiftUI
import SwiftData

@main
struct todolistApp: App {
    let container: ModelContainer = {
        let schema = Schema([Todo.self])
        let container =  try! ModelContainer(for: schema, configurations: [])
        
        return container
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(items: Todo.SampleData)
        }
        .modelContainer(container)
    }
}
