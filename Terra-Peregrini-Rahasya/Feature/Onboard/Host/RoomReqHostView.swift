//
//  RoomReqHostView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 04/07/24.
//

import SwiftUI

struct RoomReqHostView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Image.Room
                    .resizable()
                    .scaledToFit()
                    .frame(width: 172)
                
                CardView(
                    isMission: false,
                    backgroundColor: .defaults,
                    title: "Online Test Room Requirement",
                    description: "One of the candidates will host the online test in their home, if you volunteer to be the host, please select **In my home**."
                )
                .padding(.top, 28)
                
                Spacer()
                
                Text("Whose home are you attempting the test in? Is it your home?")
                    .padding(.horizontal, 24)
                    .multilineTextAlignment(.center)
                    .font(.custom("JetBrainsMono-Regular", size: 18))
                    .foregroundStyle(.white)
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 449, height: 121)
                    )
                
                Button(action: {
                    router.navigate(to: .roomcomphost)
                }, label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Yes in my home")
                            .foregroundStyle(Color.white)
                            .bold()
                            .font(.custom("JetBrainsMono-Regular", size: 18))
                    }
                })
                .padding(.top, 10)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    RoomReqHostView()
}
