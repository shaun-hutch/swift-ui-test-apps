//
//  wordle_clone_iosApp.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

import SwiftUI

@main
struct wordle_clone_iosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(board: Letter.Board)
        }
    }
}
