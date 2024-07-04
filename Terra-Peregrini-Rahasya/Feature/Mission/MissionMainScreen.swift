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
    
    @State var code: [String] = ["0","0","0","0"]
    @State var colorCode: [Color] = [.white, .white, .blue, .white]
    
    @State var isComplete = false
    
    @State var endingStatus: EndingStatus? = nil
    
    @State var isHost = false
    
    @State var point = 100
    
    var mission: Int
    
    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                Image(systemName: "trophy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
                    .padding(.leading, 40)
                    .foregroundStyle(Color.TPRColor.PrimaryBlue)
                
                Text("\(point) pts")
                    .foregroundStyle(Color.white)
                    .customFont(.bold, 18)
                    .frame(width: 43)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            ZStack {
                Image.Time
                    .resizable()
                    .scaledToFit()
                    .frame(width: 112, alignment: .leading)
                    .onTapGesture {
                        isShowClue = !isShowClue
                    }
                
                Text("20:00")
                    .foregroundStyle(Color.white)
                    .customFont(.bold, 18)
                    .frame(width: 112, alignment: .leading)
                    .offset(x: 48)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            if isShowClue {
                Image.Bell
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, 40)
                    .frame(height: 47)
                    .onTapGesture {
                        isClueClicked.toggle()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
            
            ZStack {
                Image.Card
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(cardBackgroundColor(endingStatus: endingStatus))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 324, height: 279)
                
                    .onTapGesture {
                        isShowInstruction = !isShowInstruction
                    }
                
                
                Text("897123412")
                    .foregroundStyle(Color.white)
                    .customFont(.bold, 16)
                    .padding([.top, .trailing], 48)
                    .frame(width: 324, height: 279, alignment: .topTrailing)
                
                if endingStatus != nil {
                    Text(endingStatus!.rawValue)
                        .foregroundStyle(Color.white)
                        .customFont(.bold, 22)
                        .padding(.top, 16)
                        .padding(.leading, 32)
                        .frame(width: 324, height: 279, alignment: .topLeading)
                }
                
                VStack {
                    Text(allMission[mission].tagline)
                        .foregroundStyle(Color.white)
                        .customFont(.bold, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 35)
                    
                    Text("Objective: \(.init(allMission[mission].objective))")
                        .foregroundStyle(Color.white)
                        .customFont(.regular, 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 14)
                }
                .padding(.horizontal, 32)
                .frame(width: 324, height: 279)
                
                if mission == 2 {
                    if isHost {
                        FinalColorView(colorCode: $colorCode)
                            .offset(x: 0, y: 245)
                    } else {
                        Image.DistanceCode
                            .resizable()
                            .scaledToFit()
                            .frame(width: 163)
                            .overlay(alignment: .center) {
                                Text("2")
                                    .foregroundStyle(Color.white)
                                    .customFont(.regular, 72)
                                    .multilineTextAlignment(.center)
                            }
                            .offset(x: 0, y: -194)
                    }
                }
                
                if mission == 3 {
                    FinalCodeView(code: $code, isComplete: $isComplete, endingStatus: endingStatus)
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
                        .font(.customFont(.regular, 18))
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
            VStack {
                Text("Clues:")
                    .foregroundStyle(Color.white)
                    .font(.customFont(.regular, 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(allMission[mission].clue)
                    .foregroundStyle(Color.white)
                    .font(.customFont(.regular, 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
            }
            .padding()
            .presentationDetents([ .medium])
            .presentationBackground(Color.TPRColor.LightBlue)
            .presentationDragIndicator(.visible)
        }
        .onChange(of: isComplete) {
            isShowInstruction = isComplete
        }
    }
}

#Preview {
    MissionMainScreen(mission: 2)
}
