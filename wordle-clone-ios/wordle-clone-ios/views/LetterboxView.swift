//
//  LetterboxView.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

import SwiftUI

struct LetterboxView: View {
    var letter: Letter
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(.gray, lineWidth: 0)
                .background(letter.letterBackgroundColor)
                .cornerRadius(6)
            
            Text(letter.charString)
                .font(.largeTitle)
                .fontWeight(.bold)
            
        }
        .frame(width: 50, height: 50)
    }
}

#Preview {
    LetterboxView(letter: Letter(character: "A", position: 0, status: .correctLetter))
    LetterboxView(letter: Letter(character: "B", position: 1, status: .correctPosition))
    LetterboxView(letter: Letter(character: "C", position: 2, status: .incorrectLetter))
    LetterboxView(letter: Letter(character: "C", position: 2, status: .uncheckedLetter))
    LetterboxView(letter: Letter(position: 2, status: .uncheckedLetter))
}

