//
//  WordView.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

import SwiftUI

struct WordView: View {
    var word: [Letter]
    
    var body: some View {
        HStack {
            ForEach(word, id: \.self) { letter in
                LetterboxView(letter: letter)
            }
        }
    }
}

#Preview {
    WordView(word: Letter.Example)
}
