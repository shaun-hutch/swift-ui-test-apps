//
//  GameLogic.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 18/06/2025.
//

struct Game {
    
    var answer: String
    var attempts: [Attempt]
    
    var splitAnswer: [Character] {
        Array(answer)
    }
    
    init(answer: String) {
        self.answer = answer
        self.attempts = Attempt.BlankBoard
    }
    
    mutating func Compare(_ guess: String, number: Int) {
        let splitInput = Array(guess)
                
        guard splitInput.count == 5, splitAnswer.count == 5 else {
            return
        }
        
        var remainingLetters = splitAnswer
        var letters: [Letter] = self.attempts[number].letters
        
        // First pass: check for correct position
        for i in 0 ..< splitInput.count {
            if splitInput[i] == splitAnswer[i] {
                letters[i] = Letter(character: splitInput[i], position: i, status: .correctPosition)
                if let index = remainingLetters.firstIndex(of: splitInput[i]) {
                    remainingLetters.remove(at: index)
                }
            }
        }
        
        // Second pass: check for correct letter but wrong position
        for i in 0 ..< splitInput.count {
            if letters[i].character == nil {
                if let index = remainingLetters.firstIndex(of: splitInput[i]) {
                    letters[i] = Letter(character: splitInput[i], position: i, status: .correctLetter)
                    remainingLetters.remove(at: index)
                } else {
                    letters[i] = Letter(character: splitInput[i], position: i, status: .incorrectLetter)
                }
            }
        }
        
        attempts[number] = Attempt(letters: letters.compactMap { $0 })
    }
}
