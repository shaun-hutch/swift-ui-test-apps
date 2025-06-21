//
//  Attempt.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 18/06/2025.
//

struct Attempt : Hashable {
    var letters: [Letter]
    
    init(letters: [Letter]) {
        self.letters = letters
    }
}

extension Attempt {
    static var Example =
        Attempt(letters: [
            Letter(character: "A", position: 0, status: .correctPosition),
            Letter(character: "E", position: 1, status: .incorrectLetter),
            Letter(character: "I", position: 2, status: .correctLetter),
            Letter(position: 3, status: .uncheckedLetter),
            Letter(character: "U", position: 4, status: .correctLetter),
        ])

    static var Board = [
        Example,
        Example,
        Example,
        Example,
        Example
    ]
    
    static var BlankBoard: [Attempt] {
        Array(repeating: Attempt(letters: Array(0 ..< 5).map { position in
            Letter.EmptyLetter(position: position)
        }), count: 6)
    }
}
