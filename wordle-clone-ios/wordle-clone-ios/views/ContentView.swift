//
//  ContentView.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var input: String = ""
    @State private var currentAttempt: Int = 0
    @State private var currentPosition: Int = 0
    
    @State private var game: Game = .init(answer: "SWORD")
    
    var body: some View {
        VStack {
            VStack {
                ForEach(game.attempts, id: \.self) { attempt in
                    WordView(word: attempt)
                }
            }
            .padding(.top, 50)
            
            Spacer()
            KeyboardView { char in
                onKeyPress(char)
            }
            .padding(.bottom, 50)
            
        }
    }
    
    func onKeyPress(_ key: Character) {
        print("key pressed: \(key), position: \(currentPosition)")
        if (currentPosition == 5 && key == "⏎") {
            currentPosition = 0
            game.Compare(attemptNumber: currentAttempt)
            currentAttempt += 1
        } else if (0...5).contains(currentPosition) && key == "␡" {
            if (currentPosition > 0) {
                currentPosition -= 1
                
                game.attempts[currentAttempt].letters[currentPosition].character = nil
            }
        } else if (0..<5).contains(currentPosition) && key.isLetter {
            game.attempts[currentAttempt].letters[currentPosition].character = key
            currentPosition += 1
        }
    }
}


#Preview {
    ContentView()
}
