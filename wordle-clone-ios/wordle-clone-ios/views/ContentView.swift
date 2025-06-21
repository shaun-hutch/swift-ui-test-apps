//
//  ContentView.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var isTextFieldFocused: Bool
    
    @State private var input: String = ""
    @State private var currentAttempt: Int = 0
    @State private var currentPosition: Int = 0
    
    @State private var game: Game = .init(answer: "SWORD")
    
    var body: some View {
        VStack {
            ForEach(game.attempts, id: \.self) { attempt in
                WordView(word: attempt)
            }
            textField
        }
        .onAppear() {
            isTextFieldFocused = true
        }
    }
    
    var textField: some View {
        TextField("", text: $input)
            .focused($isTextFieldFocused)
            .keyboardType(.alphabet)
            .submitLabel(.done)
            .opacity(0)
            .frame(width: 0, height: 0)
            .onChange(of: input) { oldValue, newValue in
                print("input changed, old: \(oldValue), new: \(newValue), current position: \(currentPosition)")
                if (oldValue.count == 5 && newValue.count > 5) {
                    input = oldValue
                    return
                } else if (oldValue == newValue) {
                    return
                }
                
                
                if (oldValue.count == 5 && newValue.count == 0) {
                    return
                }
                
                
                
                
                
                // check if letters a-z/backspace/enter were pressed
                let filtered = newValue.uppercased().filter { $0.isLetter && $0.isASCII }

                // If filtering changed the input, update it
                if filtered != newValue.uppercased() {
                    print("filtered: \(filtered), newValue: \(newValue)a")
                    input = filtered
                    return
                }
                
                // check if backspace, move position back, remove letter previous index (if was > 0)
                if (filtered.count < oldValue.count && currentPosition >= 0) {
                    print("backspace")
                    
                    game.attempts[currentAttempt].letters[currentPosition].character = nil
                    currentPosition -= 1
                } else if filtered.count > oldValue.count && currentPosition < 5 && currentPosition >= 0 {
                    let newChar = filtered.last
                    game.attempts[currentAttempt].letters[currentPosition].character = newChar

                    currentPosition += 1
                }
            }
            .onSubmit {
                if currentPosition == 5 {
                    game.Compare(attemptNumber: currentAttempt)
                    currentAttempt += 1
                    currentPosition = 0
                    input = ""
                }
            }
    }
}


#Preview {
    ContentView()
}
