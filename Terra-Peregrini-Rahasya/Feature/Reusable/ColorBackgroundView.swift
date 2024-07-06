//
//  ColorBackgroundView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 05/07/24.
//

import SwiftUI

struct ColorBackgroundView: View {
    
    @Binding var colorBackground : [Color]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(colorBackground, id: \.self) { color in
                color
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ColorBackgroundView(colorBackground: .constant([.red, .blue, .red, .green, .green, .blue]))
}
