//
//  Letter.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

import SwiftUI

struct Letter {
    var Character: Character
    var Position: Int
    var Status: LetterStatus
    
    var CharString: String {
        "\(Character)"
    }
    
    var LetterBackgroundColor: Color {
        switch Status {
        case .correctPosition:
            return .green
        case .correctLetter:
            return .yellow
        case .incorrectLetter:
            return .gray
        }
    }
    
    init(Character: Character, Position: Int, Status: LetterStatus) {
        self.Character = Character
        self.Position = Position
        self.Status = Status
    }
    
}
