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
                    Spacer()
                    Text("Online Recruitment Test Invitation\n")
                        .font(.custom("JetBrainsMono-Regular", size: 24))
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding()
                    
                    HStack{
                        Text("Hi Candidate, \n")
                        + Text("\nCongratulations!\n")
                        + Text("We’re pleased to inform you that you’re qualified for the final activity in our Agent Recruitment Test.\n")
                        + Text("\nPlease team up with 4 other candidates in one room to proceed.\n")
                        + Text("\nRegards,")
                    }
                    .font(.custom("JetBrainsMono-Regular", size: 18))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 60)
                    
                    Button(action: {
                        router.navigate(to: .splashscreen)
                    }, label: {
                        ZStack{
                            Image.ProceedButton
                                .resizable()
                                .frame(width: 237, height: 81)
                            Text("Open Message")
                                .foregroundStyle(Color.white)
                                .fontWeight(.bold)
                                .font(.custom("JetBrainsMono-Regular", size: 18))
                        }
                    })
                    .padding(.top, 100)
                    Spacer()
                }
            }.ignoresSafeArea()
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    InvitationView()
}
