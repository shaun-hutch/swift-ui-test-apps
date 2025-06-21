//
//  LetterStatus.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

enum LetterStatus: Int, CaseIterable {
    case correctPosition, correctLetter, incorrectLetter, uncheckedLetter
}
