//
//  Letter.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

import SwiftUI

struct Letter: Hashable {
    var character: Character?
    var position: Int
    var status: LetterStatus
    
    var charString: String {
        character.map { String($0) } ?? ""
    }
    
    var letterBackgroundColor: Color {
        switch status {
        case .correctPosition:
            return .green
        case .correctLetter:
            return .yellow
        case .incorrectLetter:
            return .gray
        }
    }
    
    init(character: Character, position: Int, status: LetterStatus) {
        self.character = character
        self.position = position
        self.status = status
    }
    
}

extension Letter {
    static var Example =
    [
        Letter(character: "A", position: 0, status: .correctPosition),
        Letter(character: "E", position: 1, status: .incorrectLetter),
        Letter(character: "I", position: 2, status: .correctLetter),
        Letter(character: "O", position: 3, status: .incorrectLetter),
        Letter(character: "U", position: 4, status: .correctLetter),
    ]
    
    static var Board = [
        Example,
        Example,
        Example,
        Example,
        Example
    ]
}
