//
//  GameLogic.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 18/06/2025.
//

struct Game {
    
    var answer: String
    var attempts: [Attempt]
    var remainingLetters: [Character]
    
    init(answer: String) {
        self.answer = answer
        self.attempts = Attempt.BlankBoard
        self.remainingLetters = Array(answer)
    }
    
    mutating func Compare(attemptNumber: Int) {
        var letters = self.attempts[attemptNumber].letters

        // First pass: correct position
        for i in 0 ..< 5 {
            if let char = letters[i].character {
                if char == remainingLetters[i] {
                    letters[i].status = .correctPosition
                    if let index = remainingLetters.firstIndex(of: char) {
                        remainingLetters.remove(at: index)
                    }
                }
            }
        }

        // Second pass: correct letter wrong position
        for i in 0 ..< 5 {
            if let char = letters[i].character {
                if let index = remainingLetters.firstIndex(of: char) {
                    letters[i].status = .correctLetter
                    remainingLetters.remove(at: index)
                } else {
                    letters[i].status = .incorrectLetter
                }
            }
        }

        attempts[attemptNumber] = Attempt(letters: letters)
    }
}
