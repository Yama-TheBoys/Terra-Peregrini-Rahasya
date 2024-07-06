//
//  ReconnectingView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 07/07/24.
//

import SwiftUI

struct ReconnectingView: View {
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.7)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Reconnecting...")
                    .foregroundStyle(.white)
                    .customFont(.bold, 24)
                    .shadow(color: .white, radius: 15)
                
                CircularProgressView(
                    progress: 0,
                    isRepeating: true,
                    lineWidth: 10,
                    color: .white
                )
                .frame(width: 50)
                .padding(.top, 12)
                
                Spacer()
            }
        }
    }
}

#Preview {
    ReconnectingView()
}
