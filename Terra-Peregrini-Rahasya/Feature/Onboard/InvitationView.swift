//
//  InvitationView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 03/07/24.
//

import SwiftUI

struct InvitationView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            ZStack{
                Image.Invitation
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
                    .offset(y: -100)
                
                VStack{
                    Text("Online Recruitment Test Invitation\n")
                        .customFont(.bold, 24)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding(.top, 48)
                    
                    Text("Hi Candidate, \n\nCongratulations! \n\nWe’re pleased to inform you that you’re qualified for the final activity in our Agent Recruitment Test. \n\nPlease team up with 4 other candidates in one room to proceed. Each of you will start with 10 points. Compete to achieve the highest score and earn a special badge from Peregrini. \n\nRegards,")
                        .customFont(.regular, 18)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 60)
                    Spacer()
                }
                .offset(y: -36)
                
                Button(action: {
                    playButtonClickSound()
                    router.navigate(to: .namecode)
                }, label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Take the Test")
                            .customFont(.bold, 18)
                            .foregroundStyle(Color.white)
                    }
                })
                .offset(y: 286)
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    InvitationView()
}
