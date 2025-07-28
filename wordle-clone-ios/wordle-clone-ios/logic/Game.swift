//
//  GameLogic.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 18/06/2025.
//

struct Game {
    
    var answer: String
    var attempts: [Attempt]
    var remainingLetters: [Character?]
    var keyboardLetterStatuses: [Character: LetterStatus] = [:]
    var gameEnded: Bool = false
    var hasWon: Bool = false
    
    init(answer: String) {
        self.answer = answer
        self.attempts = Attempt.BlankBoard
        self.remainingLetters = Array(answer)
        self.gameEnded = false
    }
    
    mutating func Compare(attemptNumber: Int) {
        var letters = self.attempts[attemptNumber].letters
        let answerArray = Array(answer)

        // This array tracks which letters in the answer have already been matched.
        // This prevents the same letter from being matched multiple times in the second pass.
        var answerLetterUsage = Array(repeating: false, count: 5)

        // First pass: identify letters in the correct position
        for i in 0..<5 {
            if let char = letters[i].character, char == answerArray[i] {
                letters[i].status = .correctPosition
                answerLetterUsage[i] = true // Mark this letter in the answer as used
            }
        }

        // Second pass: identify correct letters in the wrong position
        for i in 0..<5 {
            // Skip letters already marked as correct position
            guard letters[i].status != .correctPosition, let char = letters[i].character else {
                continue
            }

            // Find a matching letter in the answer that hasn't already been used
            if let index = answerArray.firstIndex(where: { answerChar in
                answerChar == char && !answerLetterUsage[answerArray.firstIndex(of: answerChar)!]
            }) {
                letters[i].status = .correctLetter
                answerLetterUsage[index] = true // Mark this match as used
            } else {
                letters[i].status = .incorrectLetter
            }
        }

        // Update the attempt with the new letter statuses
        attempts[attemptNumber] = Attempt(letters: letters)
        
        // update the keyboard letter statuses based on the result of the comparison above
        for letter in attempts[attemptNumber].letters {
            guard let char = letter.character else { continue }

            let existingStatus = keyboardLetterStatuses[char] ?? .uncheckedLetter

            // Only upgrade status if it's more informative (correctPosition > correctLetter > incorrectLetter)
            if letter.status == .correctPosition ||
                (letter.status == .correctLetter && existingStatus == .uncheckedLetter) ||
                (letter.status == .incorrectLetter && existingStatus == .uncheckedLetter) {
                keyboardLetterStatuses[char] = letter.status
            }
        }
        
        // Determine if the current attempt is a win
        hasWon = letters.allSatisfy { $0.status == .correctPosition }
        // Update gameEnded to reflect either win or max attempts reached
        gameEnded = hasWon || attemptNumber == attempts.count - 1
    }
}
