//
//  CircularProgressView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 04/07/24.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.TPRColor.LightPurple.opacity(0.5),
                    lineWidth: 20
                )
                .shadow(color: Color.TPRColor.LightPurple.opacity(0.5) ,radius: 10)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.TPRColor.LightPurple,
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
                .shadow(color: Color.TPRColor.LightPurple ,radius: 10)
        }
    }
}

#Preview {
    CircularProgressView(progress: 0.5)
}
