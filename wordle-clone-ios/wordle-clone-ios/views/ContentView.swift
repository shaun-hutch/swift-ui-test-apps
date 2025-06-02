//
//  ContentView.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 02/06/2025.
//

import SwiftUI

struct ContentView: View {
    var board: [[Letter]]
    
    var body: some View {
        VStack {
            ForEach(board, id: \.self) { word in
                WordView(word: word)
            }
        }
    }
}

#Preview {
    ContentView(board: Letter.Board)
}
