//
//  ActivityView.swift
//  wordle-clone-ios
//
//  Created by Shaun Hutchinson on 28/07/2025.
//

import UIKit
import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
