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
    @State var isClueClicked = false
    
    @State var code: [String] = ["0","0","0","0"]
    //    @State var colorCode: [Color] = [.white, .white, .blue, .white]
    
    @State var colorBackground: [Color] = [.red, .blue, .red, .green, .green, .blue]
    
    @State var isComplete = false
    
    @State var endingStatus: EndingStatus = .ingame
    
    @State var isHost = false
    
    @State var point = 100

    @State private var isPopUpActive: Bool = false
    
    @State private var isFromVotingScreen: Bool = false
    
    @State private var isOtherDeviceDetected: Bool = false
    @State private var instructionMessage: String = Instructions.almostThere.rawValue
    
    var mission: Int
    
    var body: some View {
        ZStack {
            
            if mission == 1 {
                ColorBackgroundView(colorBackground: $colorBackground)
                    .ignoresSafeArea()
            } else {
                Color.TPRColor.PrimaryPurple
                    .ignoresSafeArea()
            }
            
            ZStack {
                Color.TPRColor.DarkPurple
                    .frame(width: 90, height: 47)
                    .padding(.leading, 40)
                    .blur(radius: 10)
                
                HStack(alignment: .center, spacing: 5) {
                    Image(systemName: "trophy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .padding(.leading, 40)
                        .foregroundStyle(Color.TPRColor.PrimaryBlue)
                    
                    Text("\(point) pts")
                        .foregroundStyle(Color.white)
                        .customFont(.bold, 16)
                        .frame(width: 43)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .onTapGesture {
                isOtherDeviceDetected = !isOtherDeviceDetected
            }
            
            ZStack {
                Color.TPRColor.DarkPurple
                    .frame(width: 112, height: 47)
                    .blur(radius: 10)
                
                Image.Time
                    .resizable()
                    .scaledToFit()
                    .frame(width: 112, alignment: .leading)
                
                Text("20:00")
                    .foregroundStyle(Color.white)
                    .customFont(.bold, 18)
                    .frame(width: 112, alignment: .leading)
                    .offset(x: 48)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onTapGesture {
                isHost = !isHost
            }
            
            ZStack {
                Color.TPRColor.DarkPurple
                    .frame(width: 65, height: 47)
                    .padding(.trailing, 40)
                    .blur(radius: 10)
                
                Image.Bell
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, 40)
                    .frame(height: 47)
            }
            .onTapGesture {
                isPopUpActive = true
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            ZStack {
                CardView(
                    isMission: true,
                    backgroundColor: endingStatus,
                    title: allMission[mission].tagline,
                    description: "Objective: \(allMission[mission].objective)"
                )
                .onTapGesture {
                    isShowInstruction = !isShowInstruction
                }
                
                if mission == 1 && isOtherDeviceDetected {
                    
                    VStack {
                        Spacer()
                        
                        HStack(spacing: 0) {
                            Button(action: {
                                
                            }, label: {
                                ZStack{
                                    Image.ProceedButton
                                        .resizable()
                                    
                                    Text("Send")
                                        .foregroundStyle(Color.white)
                                        .customFont(.bold, 18)
                                }
                            })
                            .frame(width: 153, height: 81)
                            
                            Button(action: {
                                
                            }, label: {
                                ZStack{
                                    Image.ProceedButton
                                        .resizable()
                                        .scaleEffect(x: -1, y: 1)
                                    
                                    Text("Accept")
                                        .foregroundStyle(Color.white)
                                        .customFont(.bold, 18)
                                }
                            })
                            .frame(width: 153, height: 81)
                        }
                    }
                    
                }
                
                //                if mission == 2 {
                //                    if isHost {
                //                        FinalColorView(colorCode: $colorCode)
                //                            .offset(x: 0, y: 245)
                //                    } else {
                //                        Image.DistanceCode
                //                            .resizable()
                //                            .scaledToFit()
                //                            .frame(width: 163)
                //                            .overlay(alignment: .center) {
                //                                Text("2")
                //                                    .foregroundStyle(Color.white)
                //                                    .customFont(.regular, 72)
                //                                    .multilineTextAlignment(.center)
                //                            }
                //                            .offset(x: 0, y: -194)
                //                    }
                //                }
                
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
                    
                    Text(instructionMessage)
                        .foregroundStyle(Color.white)
                        .font(.customFont(.regular, 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 34)
                }
                .padding(.bottom, 81)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .onTapGesture {
                    endingStatus = EndingStatus.allCases.randomElement() ?? .ingame
                    if endingStatus == .success || endingStatus == .failed {
                        isOtherDeviceDetected = false
                    }
                }
            }
            
            if endingStatus == .success || endingStatus == .failed {
                VStack {
                    Spacer()
                    
                    Button(action: {
                        if endingStatus == .success {
                            if mission < 3 {
                                router.navigate(to: .missionIntro(mission + 1))
                            } else {
                                router.navigate(to: .splashscreen)
                            }
                        } else {
                            router.navigate(to: .splashscreen)
                        }
                    }, label: {
                        ZStack{
                            Image.ProceedButton
                                .resizable()
                            
                            Text(
                                endingStatus == .success ? "Continue" :
                                    endingStatus == .failed ? "Leave Test" : "Leave Test"
                            )
                            .foregroundStyle(Color.white)
                            .customFont(.bold, 18)
                        }
                    })
                    .frame(width: 237, height: 81)
                }
            }
            
            if isPopUpActive {
                PopUpView(
                    isActive: $isPopUpActive,
                    message: "Are you sure you need extra clues?",
                    onYes: {
                        print("User selected Yes")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isFromVotingScreen = true
                            router.navigate(to: .votingScreen)
                        }
                        
                    },
                    onNo: {
                        print("User selected No")
                    }
                )
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isClueClicked) {
            VStack {
                Text("Clues:")
                    .foregroundStyle(Color.white)
                    .font(.customFont(.regular, 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(allMission[mission].clue)
                    .foregroundStyle(Color.white)
                    .font(.customFont(.regular, 24))
                    .padding(.top, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .presentationDetents([ .fraction(0.25)])
            .presentationBackground(Color.TPRColor.LightBlue)
            .presentationDragIndicator(.visible)
        }
        .onChange(of: isComplete) {
            isShowInstruction = isComplete
        }
        .onAppear {
            if isFromVotingScreen {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isClueClicked = true
                    isFromVotingScreen = false
                }
            }
        }
    }
}

#Preview {
    MissionMainScreen(mission: 1)
}
