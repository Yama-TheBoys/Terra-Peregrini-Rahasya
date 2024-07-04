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
                
                ZStack{
                    Image.InfoCard
                        .resizable()
                        .frame(width: 324, height: 300)
                    
                    VStack{
                        Text("Checking Room Compability")
                            .bold()
                            .font(.custom("JetBrainsMono-Regular", size: 24))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 64)
                            .padding(.leading, -64)
                            .padding()
                        
                        HStack{
                            Text("This test requires ")
                            + Text("high-tech ")
                                .bold()
                            + Text("items installed in your room. To check your ")
                            + Text("home's compatibility, ")
                                .bold()
                            + Text("please connect to the ")
                            + Text("Test System.")
                                .bold()
                        }
                            .font(.custom("JetBrainsMono-Regular", size: 16))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 62)
                        
                        
                    }
                    .padding(.top, 48)
                }
                
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
