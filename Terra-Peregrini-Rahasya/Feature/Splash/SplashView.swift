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
            
            VStack{
                Spacer()
                Text("Terra Peregrini Rahasya")
                    .padding(.horizontal, 85)
                    .fontWeight(.bold)
                    .font(.custom("JetBrainsMono-Regular", size: 40))
                    .foregroundStyle(Color.white)
                
                Spacer()
                
                Button {
                    playButtonClickSound()
                    router.navigate(to: .email)
                } label: {
                    ZStack{
                        Image.EnterGameButton
                            .resizable()
                            .frame(width: 361, height: 60)
                        Text("Enter Game")
                            .foregroundStyle(Color.white)
                            .fontWeight(.bold)
                            .font(.custom("JetBrainsMono-Regular", size: 24))
                    }
                }
                .padding()

            }
        }
        .navigationBarBackButtonHidden()
    }
    
}

#Preview {
    SplashView()
}
