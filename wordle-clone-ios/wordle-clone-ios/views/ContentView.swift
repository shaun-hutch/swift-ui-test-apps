//
//  ContentView.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

import SwiftUI

struct ContentView: View {
    
    var game: Game = .init(answer: "SWORD")
    
    var body: some View {
        VStack {
            ForEach(game.attempts, id: \.self) { attempt in
                WordView(word: attempt)
            }
        }
    }
}

#Preview {
    ContentView(game: .init(answer: "SWORD"))
}
