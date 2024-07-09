//
//  CreditsView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 05/07/24.
//

import SwiftUI

struct CreditsView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Text("CREDITS")
                    .customFont(.bold, 32)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 24)
                    .padding(.bottom, 48)
                
                Spacer()
                
                Text("Developer:")
                    .customFont(.regular, 24)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                Text("YNTB")
                    .customFont(.regular, 16)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Text("Art Design:")
                    .customFont(.regular, 24)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                Text("YNTB")
                    .customFont(.regular, 16)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Text("Sounds:")
                    .customFont(.regular, 24)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                Text("kayugames.itch.io \n wangleline.itch.io \n Benjamin Botkin")
                    .customFont(.regular, 16)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    
                Spacer()
                Spacer()
                
                Text("Every ending is a new beginning.")
                    .customFont(.regular, 18)
                    .foregroundStyle(.white)
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 449, height: 150)
                    )
                    .padding()
                
                Button(action: {
                    playButtonClickSound()
                    playOpeningSound()
                    router.navigate(to: .splashscreen)
                }, label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Finish")
                            .customFont(.bold, 18)
                            .foregroundStyle(Color.white)
                    }
                })
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreditsView()
}
