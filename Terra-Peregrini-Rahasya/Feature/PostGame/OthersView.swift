//
//  OthersView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 05/07/24.
//

import SwiftUI

struct OthersView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                ZStack{
                    Image.InfoCard
                        .resizable()
                        .frame(width: 324, height: 279)
                    
                    VStack{
                        Text("YOU’RE OFFICIALLY A TAPERA AGENT")
                            .customFont(.bold, 18)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 64)
                            .padding(.top, 36)
                        Spacer()
                        Text("Though you failed to earn our special badge, you still managed to get through all the missions. You've proven your worth and deserve to be our agents.")
                            .customFont(.regular, 14)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 24)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 24)
                    }
                    .frame(width: 324, height: 220)
                }
                
                Spacer()
                
                Text("It’s time to grab your agent ID. Let’s snap a picture.")
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
                    router.navigate(to: .takepicture)
                }, label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Take ID Picture")
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
    OthersView()
}
