//
//  MissionMainScreen.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 04/07/24.
//

import SwiftUI

struct MissionMainScreen: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var connectivityManager: ConnectivityManager
    @EnvironmentObject var missionManager: MissionManager
    
    @State var isShowInstruction = false
    @State var isClueClicked = false
    
    @State var code: [String] = ["0","0","0","0"]
    //    @State var colorCode: [Color] = [.white, .white, .blue, .white]
    
    @State var colorBackground: [Color] = [.red, .blue, .red, .green, .green, .blue]
    
    @State var isAllGameComplete = false
    
    @State var endingStatus: EndingStatus = .ingame
    
    @State var isHost = false
    
    @State private var isPopUpActive: Bool = false
    @State private var isOverlayActive: Bool = false
    
    @State private var isFromVotingScreen: Bool = false
    
    @State private var isOtherDeviceDetected: Bool = false
    @State private var instructionMessage: String = Instructions.almostThere.rawValue
    
    @State private var isTimesUp: Bool = false
    
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
                    
                    Text("\(missionManager.playerPoints) pts")
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
            
            CountdownTimerView(
                initialTime: 1200,
                isTimesUp: $isTimesUp
            )
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
                playClueSound()
                isPopUpActive = true
                connectivityManager.sendRequestForClue()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            ZStack {
                CardView(
                    isMission: true,
                    backgroundColor: endingStatus,
                    title: allMission[mission].tagline,
                    description: allMission[mission].objective
                )
                
                if mission == 1 && isOtherDeviceDetected {
                    
                    VStack {
                        Spacer()
                        
                        HStack(spacing: 0) {
                            Button(action: {
                                playButtonClickSound()
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
                                playButtonClickSound()
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
                
                if mission == 3 {
                    FinalCodeView(code: $code, isComplete: $isAllGameComplete, endingStatus: endingStatus)
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
            }
            
            if endingStatus == .failed {
                VStack {
                    Spacer()
                    
                    Button(action: {
                        playButtonClickSound()
                        playOpeningSound()
                        router.navigate(to: .splashscreen)
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
                        connectivityManager.sendRequestToVote()
                    },
                    onNo: {
                        print("User selected No")
                    }
                )
            }
            
            if isOverlayActive {
                PointResultView(
                    choosenPlayer: "",
                    isVoting: false,
                    isFirstBlood: connectivityManager.isSelfFirstBlood,
                    onAction: {
                        overlayAfterMissionSucceed()
                        playButtonClickSound()
                    }
                )
                .onAppear{
                    playPointEarnedSound()
                    if mission == 3 {
                        stopSound()
                    }
                }
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
                    .font(.customFont(.regular, 18))
                    .padding(.top, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .presentationDetents([ .fraction(0.25)])
            .presentationBackground(Color.TPRColor.LightBlue)
            .presentationDragIndicator(.visible)
        }
        .onChange(of: isAllGameComplete) {
            isShowInstruction = isAllGameComplete
        }
        .onChange(of: endingStatus) {
            showOverlayAfterMissionSuccess()
        }
        .onAppear {
            onScreenAppear()
        }
        .onChange(of: missionManager.isFirstMissionDone) {
            firstMissionCorrect()
        }
        .onChange(of: connectivityManager.isAllPlayerCorrectFirstMission) {
            firstMissionComplete()
        }
        .onChange(of: isTimesUp) {
            missionTimesUp()
        }
        .onChange(of: missionManager.doneTimeStamp) {
            assignSelfTimeStamp()
        }
        .onChange(of: connectivityManager.isShowPopUpVote, {
            isPopUpActive = connectivityManager.isShowPopUpVote
        })
        .onChange(of: connectivityManager.isMoveToVotePage) {
            moveToVoting()
        }
    }
    
    func missionTimesUp() {
        if isTimesUp {
            self.endingStatus = .failed
            missionManager.endFirstMission()
        }
    }
    
    func moveToVoting() {
        if connectivityManager.isMoveToVotePage {
            missionManager.pauseFirstMission()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isFromVotingScreen = true
                router.navigate(to: .votingScreen)
            }
        }
    }
    
    func onScreenAppear() {
        if isFromVotingScreen {
            connectivityManager.resetStatusVote()
            missionManager.startFirstMission()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isClueClicked = true
                isFromVotingScreen = false
            }
        } else {
            connectivityManager.sendMessagePlayerStartMission()
            if mission == 0 {
                missionManager.startFirstMission()
            }
        }
    }
    
    func assignSelfTimeStamp() {
        if let timestamp = missionManager.doneTimeStamp {
            connectivityManager.selfTimeStamp = timestamp
            connectivityManager.sendTimeStamp(timestamp: timestamp)
        }
    }
    
    func overlayAfterMissionSucceed() {
        if connectivityManager.isSelfFirstBlood {
            missionManager.playerPoints += 25
        } else {
            missionManager.playerPoints += 10
        }
        
        connectivityManager.resetStatusMission()
        router.navigate(to: .leaderboard)
//        if mission < 3 {
//            router.navigate(to: .missionIntro(mission + 1))
//        } else {
//            router.navigate(to: .leaderboard)
//        }
    }
    
    func showOverlayAfterMissionSuccess() {
        if endingStatus == .success {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isOverlayActive = true
            }
        }
    }
    
    func firstMissionCorrect() {
        if missionManager.isFirstMissionDone {
            DispatchQueue.main.async {
                self.isShowInstruction = true
            }
        } else {
            DispatchQueue.main.async {
                self.isShowInstruction = false
            }
        }
        connectivityManager.sendMessageCorrectFirstMission(correct: missionManager.isFirstMissionDone)
    }
    
    func firstMissionComplete() {
        if connectivityManager.isAllPlayerCorrectFirstMission {
            missionManager.endFirstMission()
            
            self.endingStatus = .success
        }
    }
}

#Preview {
    MissionMainScreen(mission: 1)
}
