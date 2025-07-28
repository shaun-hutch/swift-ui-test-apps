//
//  KeyboardView.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 22/06/2025.
//

import SwiftUI

struct KeyboardView: View {
    

    var keyStatuses: [Character : LetterStatus]
    var keyPress: (Character) -> Void
    
    var body: some View {
        VStack(spacing: 4) {
            keyRow(Constants.topKeys)
            keyRow(Constants.middleKeys)
            keyRow(Constants.bottomKeys)
        }
    }
    
    func keyRow(_ keys: [Character]) -> some View {
        HStack(spacing: 4) {
            ForEach(keys, id: \.self) { key in
                LetterboxView(letter: Letter.init(character: key, position: -1, status: keyStatuses[key, default: .uncheckedLetter]), width: 32, height: 45, font: .title2)
                    .onTapGesture {
                        keyPress(key)
                    }
            }
        }
    }
}


#Preview {
    KeyboardView(
        keyStatuses: [
            "A": .correctPosition,
            "S": .correctLetter,
            "D": .incorrectLetter,
            "L": .correctLetter,
            "E": .uncheckedLetter
        ]
    ) { char in
        print("character pressed: \(char)")
    }
}
