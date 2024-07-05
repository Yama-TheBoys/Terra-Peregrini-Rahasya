//
//  MissionIntro.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 03/07/24.
//

import SwiftUI

struct MissionIntro: View {
    @EnvironmentObject var router: Router
    
    @State var isWaiting = false
    
    var mission: Int = 3
    
    var body: some View {
        VStack {
            if isWaiting {
                WaitingPlayerView(destination: Router.Destination.missionMainScreen(mission))
                    .environmentObject(router)
            } else {
                VStack {
                    ZStack {
                        Image.MissionTitle
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        VStack {
                            Text("Test \(mission + 1)")
                                .foregroundStyle(Color.white)
                                .customFont(.bold, 24)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(allMission[mission].name)
                                .foregroundStyle(Color.white)
                                .customFont(.bold, 32)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 24)
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.horizontal, 34)
                    
                    Text(allMission[mission].description)
                        .foregroundStyle(Color.white)
                        .customFont(.regular, 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .horizontal], 34)
                    
                    Spacer()
                    
                    HStack {
                        ZStack {
                            Image.Timer
                                .resizable()
                                .scaledToFit()
                                .frame(width: 193, alignment: .leading)
                                .padding(.leading, -64)
                            
                            Text("20 minutes")
                                .foregroundStyle(Color.white)
                                .fontWeight(.bold)
                                .customFont(.regular, 18)
                                .frame(width: 193, alignment: .leading)
                                .padding(.leading, 64)
                        }
                        
                        Spacer()
                    }
                    .offset(y: 15)
                    
                    ZStack {
                        Image.Instruction
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: Color.TPRColor.SecondaryPurple ,radius: 10)
                        
                        Text("Are you ready to take the \(allMission[mission].order) Test?")
                            .foregroundStyle(Color.white)
                            .customFont(.regular, 18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 34)
                    }
                    
                    Button(action: {
                        isWaiting = true
                    }, label: {
                        ZStack{
                            Image.ProceedButton
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                            Text("Proceed")
                                .foregroundStyle(Color.white)
                                .customFont(.bold, 18)
                        }
                    })
                    .frame(width: 237, height: 81)
                    .offset(y: -15)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.TPRColor.PrimaryPurple)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MissionIntro().environmentObject(Router())
}
