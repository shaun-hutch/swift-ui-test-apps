//
//  ContentView.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var currentAttempt: Int = 0
    @State private var currentPosition: Int = 0
    @State private var isGameEnded: Bool = false
    
    @State private var game: Game = .init(answer: "SWORD")
    
    var body: some View {
        VStack {
            VStack {
                ForEach(game.attempts, id: \.self) { attempt in
                    WordView(word: attempt)
                }
            }
            .padding(.top, 70)
            
            Spacer()
            KeyboardView(keyStatuses: game.keyboardLetterStatuses) { char in
                onKeyPress(char)
            }
            .disabled(isGameEnded)
            .padding(.bottom, 70)
            
            if (isGameEnded) {
                Text(game.hasWon ? "You win!" : "You lose!")
                    .font(.largeTitle)
                    .foregroundColor(game.hasWon ? .green : .red)
                
                Button("Reset") {
                    // choose another word
                    game = .init(answer: "PLONK")
                    currentAttempt = 0
                    currentPosition = 0
                    isGameEnded = false
                }
                
                Button("Share") {
                    
                }
            }
        }
    }
    
    func onKeyPress(_ key: Character) {
        print("key pressed: \(key), position: \(currentPosition), current attempt: \(currentAttempt)")
        if (currentPosition == 5 && key == "⏎") {
            currentPosition = 0
            game.Compare(attemptNumber: currentAttempt)
            currentAttempt += 1
            
            // check if game has been won
            if (game.gameEnded) {
                isGameEnded = true
            }
            
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
