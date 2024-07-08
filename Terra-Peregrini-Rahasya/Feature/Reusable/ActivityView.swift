//
//  ActivityView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 08/07/24.
//

import Foundation
import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let customActivity = SaveImageActivity()
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: [customActivity])

        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No update needed
    }
}
