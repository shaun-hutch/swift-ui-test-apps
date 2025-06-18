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
        case .incorrectLetter, .emptyLetter:
            return .gray
        }
    }
    
    init(character: Character? = nil, position: Int, status: LetterStatus) {
        self.character = character
        self.position = position
        self.status = status
    }
    
}

extension Letter {
    static func EmptyLetter(position: Int) -> Letter {
        Letter(position: position, status: .emptyLetter)
    }
}
