//
//  WordView.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

import SwiftUI

struct WordView: View {
    var word: Attempt
    
    var body: some View {
        HStack {
            ForEach(word.letters, id: \.self) { letter in
                LetterboxView(letter: letter)
            }
        }
    }
}

#Preview {
    WordView(word: Attempt.Example)
}
