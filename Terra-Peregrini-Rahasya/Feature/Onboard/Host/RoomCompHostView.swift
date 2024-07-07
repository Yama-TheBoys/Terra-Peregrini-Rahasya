//
//  RoomCompHost.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 04/07/24.
//

import SwiftUI

struct RoomCompHostView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Button(action: {
                    router.navigateBack()
                }, label: {
                    ZStack{
                        Image.BackButton
                            .resizable()
                            .scaledToFit()
                            .frame(width: 82)
                        Text("BACK")
                            .bold()
                            .font(.custom("JetBrainsMono-Regular", size: 16))
                            .foregroundStyle(.white)
                    }
                })
                .padding(.trailing, 280)
                
                Image.Room
                    .resizable()
                    .scaledToFit()
                    .frame(width: 172)
                
                CardView(
                    isMission: false,
                    backgroundColor: .defaults,
                    title: "Checking Room Compability",
                    description: "This test requires **high-tech** items installed in your room. To check your **home's compatibility**, please connect to the **Test System**."
                )
                .padding(.top, 28)
                
                Spacer()
                
                Text("Check your room compatibility before starting the test.")
                    .padding(.horizontal, 24)
                    .multilineTextAlignment(.center)
                    .font(.custom("JetBrainsMono-Regular", size: 18))
                    .foregroundStyle(.white)
                    .bold()
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 449, height: 121)
                    )
                
                Button(action: {
                    playButtonClickSound()
                    router.navigate(to: .selecthome)
                }, label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .frame(width: 264, height: 81)
                        Text("Check Compability")
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
    RoomCompHostView()
}
