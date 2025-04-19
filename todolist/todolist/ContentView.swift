//
//  ContentView.swift
//  todolist
//
//  Created by Shaun Hutchinson on 14/04/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Todo.date) var todos: [Todo]
    @Query(filter: #Predicate<Todo> {
        $0.isCompleted == false
    }, sort: \Todo.date)
    
    @State var items: [Todo]
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($items, id: \.id) { $item in
                        TodoItemView(todoItem: $item)
                       
                    }
                }
                
            }
            .navigationTitle("Todo List")
        }
    }
}

#Preview {
    ContentView(items: Todo.SampleData)
}
