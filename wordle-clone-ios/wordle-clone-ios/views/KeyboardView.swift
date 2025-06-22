//
//  KeyboardView.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 22/06/2025.
//

import SwiftUI

struct KeyboardView: View {
    

    var keyPress: (Character) -> Void
    
    var body: some View {
        VStack {
            keyRow(Constants.topKeys)
            keyRow(Constants.middleKeys)
            keyRow(Constants.bottomKeys)
        }
    }
    
    func keyRow(_ keys: [Character]) -> some View {
        HStack {
            ForEach(keys, id: \.self) { key in
                LetterboxView(letter: Letter.init(character: key, position: -1, status: .uncheckedLetter), width: 30, height: 40, font: .title2)
                    .onTapGesture {
                        keyPress(key)
                    }
            }
        }
    }
    
}


#Preview {
    KeyboardView { char in
        print("character pressed: \(char)")
    }
}
