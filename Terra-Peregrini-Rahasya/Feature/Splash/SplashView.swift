//
//  SplashView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 23/06/24.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            Image.SplashScreen
                .resizable()
                .ignoresSafeArea()
            
            Image.WaveForm
                .resizable()
            
            VStack{
                Text("Terra Peregrini Rahasya")
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 120)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.TPRColor.PrimaryBlue)
                
                Image(systemName: "touchid")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.white)
                    .offset(y: 210)
                    .onTapGesture {
                        router.navigate(to: .onboard)
                    }
                
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
    
    // TODO: Niko create function to wait for 2 seconds then navigate to StartView
}

#Preview {
    SplashView()
}
