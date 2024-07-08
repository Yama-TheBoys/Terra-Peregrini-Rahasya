//
//  CircularProgressView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 04/07/24.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    var isRepeating: Bool = false
    var lineWidth: CGFloat
    var color: Color
    var duration: TimeInterval = 3
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    color.opacity(0.5),
                    lineWidth: lineWidth
                )
                .shadow(color: color.opacity(0.5) ,radius: 10)
            
            if isRepeating {
                Circle()
                    .trim(from: 0, to: 0.2)
                    .stroke(
                        color,
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                    .animation(
                        Animation.linear(duration: 1).repeatForever(autoreverses: false),
                        value: isAnimating
                    )
//                    .shadow(color: color ,radius: 10)
                    .blur(radius: 2)
            } else {
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        color,
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut(duration: duration), value: progress)
                    .shadow(color: color ,radius: 10)
            }
            
        }
        .onAppear {
            self.isAnimating = true
        }
    }
}

#Preview {
    CircularProgressView(progress: 0.5, isRepeating: true, lineWidth: 15, color: Color.TPRColor.LightPurple)
        .scaledToFit()
        .frame(width: 100)
}
