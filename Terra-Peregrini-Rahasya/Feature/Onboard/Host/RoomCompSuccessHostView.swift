//
//  RoomCompSuccessHostView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 04/07/24.
//

import SwiftUI

struct RoomCompSuccessHostView: View {
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
                            .customFont(.bold, 16)
                            .foregroundStyle(.white)
                    }
                })
                .padding(.trailing, 280)
                
                Spacer()
                
                ZStack{
                    Image.SuccessCard
                        .resizable()
                        .frame(width: 324, height: 367)
                    
                    Text("1237856619")
                        .customFont(.bold, 16)
                        .foregroundStyle(.white)
                        .padding([.top, .trailing], 48)
                        .frame(width: 324, height: 367, alignment: .topTrailing)
                    
                    VStack{
                        Text("Room Compatibility Check: SUCCESS")
                            .customFont(.bold, 24)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 48)
                        
                        Text("Your **TEST** is to complete challenges and solve puzzles in your environment. Only those with exceptional skills, intelligence, and teamwork will join our elite agency.")
                            .customFont(.regular, 16)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)
                    }
                    .padding(.horizontal, 32)
                    .frame(width: 324, height: 367)
                }
                
                Spacer()
                
                Text("Connected Successfully")
                    .customFont(.bold, 18)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 449, height: 121)
                    )
                
                Button(action: {
                    router.navigate(to: .missionIntro)
                }, label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Start Test")
                            .customFont(.bold, 18)
                            .foregroundStyle(Color.white)
                    }
                })
                .padding(.top, 20)
                
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    RoomCompSuccessHostView()
}
