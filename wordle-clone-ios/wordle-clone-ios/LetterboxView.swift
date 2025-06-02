//
//  LetterboxView.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

import SwiftUI

struct LetterboxView: View {
    var letter: Character?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(.gray, lineWidth: 2)
                .background(Color.white)
                .cornerRadius(6)
            
            if letter != nil {
                Text(
            }
        }
        .frame(width: 50, height: 50)
    }
}

#Preview {
    LetterboxView(letter: "A")
}

