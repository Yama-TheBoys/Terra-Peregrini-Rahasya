//
//  MissionMainScreen.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 04/07/24.
//

import SwiftUI

struct MissionMainScreen: View {
    
    @EnvironmentObject var router: Router
    
    @State var isShowInstruction = false
    @State var isShowClue = false
    @State var isClueClicked = false
    
    @State var code: Int = 0
    
    var mission: Int
    
    var body: some View {
        ZStack {
            HStack {
                ZStack {
                    Image.Time
                        .resizable()
                        .scaledToFit()
                        .frame(width: 112, alignment: .leading)
                        .padding(.leading, -46)
                        .onTapGesture {
                            isShowClue = !isShowClue
                        }
                    
                    Text("20:00")
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .font(.custom("JetBrainsMono-Regular", size: 18))
                        .frame(width: 112, alignment: .leading)
                        .padding(.leading, 46)
                }
                
                Spacer()
                
                if isShowClue {
                    Image.Bell
                        .resizable()
                        .scaledToFit()
                        .frame(height: 47)
                        .onTapGesture {
                            isClueClicked.toggle()
                        }
                }
            }
            .padding(.horizontal, 34)
            .frame(maxHeight: .infinity, alignment: .top)
            
            ZStack {
                Image.Card
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 324, height: 279)
                    .onTapGesture {
                        isShowInstruction = !isShowInstruction
                    }
                
                
                Text("897123412")
                    .foregroundStyle(Color.white)
                    .font(.custom("JetBrainsMono-Regular", size: 16))
                    .padding([.top, .trailing], 48)
                    .frame(width: 324, height: 279, alignment: .topTrailing)
                    
                
                VStack {
                    Text(allMission[mission].tagline)
                        .foregroundStyle(Color.white)
                        .font(.custom("JetBrainsMono-Regular", size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 35)
                    
                    Text("Objective: \(allMission[mission-1].objective)")
                        .foregroundStyle(Color.white)
                        .font(.custom("JetBrainsMono-Regular", size: 14))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 14)
                }
                .padding(.horizontal, 32)
                .frame(width: 324, height: 279)
                
                if mission == 2 {
                    Image.DistanceCode
                        .resizable()
                        .scaledToFit()
                        .frame(width: 163)
                        .overlay(alignment: .center) {
                            Text("2")
                                .foregroundStyle(Color.white)
                                .font(.custom("JetBrainsMono-Regular", size: 72))
                                .multilineTextAlignment(.center)
                        }
                        .offset(x: 0, y: -194)
                        
                }
                
                if mission == 3 {
                    HStack(spacing: 0) {
                        Image.FinalCode
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72)
                            .shadow(color: Color.TPRColor.LightPurple ,radius: 1.5)
                            .overlay(alignment: .center) {
                                TextField("", value: $code, formatter: NumberFormatter())
                                    .foregroundStyle(Color.white)
                                    .font(.custom("JetBrainsMono-Regular", size: 28))
                                    .multilineTextAlignment(.center)
                                    
                            }
                        
                        Image.FinalCode
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72)
                            .shadow(color: Color.TPRColor.LightPurple ,radius: 1.5)
                            .overlay(alignment: .center) {
                                TextField("", value: $code, formatter: NumberFormatter())
                                    .foregroundStyle(Color.white)
                                    .font(.custom("JetBrainsMono-Regular", size: 28))
                                    .multilineTextAlignment(.center)
                                    
                            }
                        
                        Image.FinalCode
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72)
                            .shadow(color: Color.TPRColor.LightPurple ,radius: 1.5)
                            .overlay(alignment: .center) {
                                TextField("", value: $code, formatter: NumberFormatter())
                                    .foregroundStyle(Color.white)
                                    .font(.custom("JetBrainsMono-Regular", size: 28))
                                    .multilineTextAlignment(.center)
                                    
                            }
                        
                        Image.FinalCode
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72)
                            .shadow(color: Color.TPRColor.LightPurple ,radius: 1.5)
                            .overlay(alignment: .center) {
                                TextField("", value: $code, formatter: NumberFormatter())
                                    .foregroundStyle(Color.white)
                                    .font(.custom("JetBrainsMono-Regular", size: 28))
                                    .multilineTextAlignment(.center)
                                    
                            }
                    }
                    .offset(x: 0, y: -165)
                }
                
                
            }
            
            if isShowInstruction {
                ZStack {
                    Image.Instruction
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: Color.TPRColor.SecondaryPurple ,radius: 10)
                    
                    Text("Almost there...")
                        .foregroundStyle(Color.white)
                        .font(.custom("JetBrainsMono-Regular", size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 34)
                }
                .padding(.bottom, 81)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.TPRColor.PrimaryPurple)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isClueClicked) {
            VStack(alignment: .leading) {
                Text("Clues:")
                    .foregroundStyle(Color.white)
                    .font(.custom("JetBrainsMono-Regular", size: 20))
                
                Text("You guys made it!\n\nEven with the clue I gave last time, the test was still tough, so well done on passing the first one.\n\nNow, for the second test, focus on how you interact with each other.\n\nIf you can pass this stage, I'm sure you're truly meant for this position!")
                    .foregroundStyle(Color.white)
                    .font(.custom("JetBrainsMono-Regular", size: 16))
                    .padding(.top, 16)
            }
            .padding()
            .presentationDetents([ .medium])
            .presentationBackground(Color.TPRColor.LightBlue)
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    MissionMainScreen(mission: 3)
}
