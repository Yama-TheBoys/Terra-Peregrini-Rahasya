//
//  SplashView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 23/06/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            Image("splashscreen").ignoresSafeArea()
            
            VStack{
                Text("Terra Peregrini Rahasya")
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 120)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Image(systemName: "touchid")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.white)
                    .offset(y: 210)
                
                Text("Sign your fingerprint to enter")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    .offset(y: 260)

            }
        }
    }
}

#Preview {
    SplashView()
}
