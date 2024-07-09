//
//  VotingView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 05/07/24.
//

import SwiftUI

struct VotingView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var connectivityManager: ConnectivityManager
    @EnvironmentObject var missionManager: MissionManager
        
    @State var isVotingDone = false
    
    @State var choosenPlayer : String = ""
    
    var body: some View {
        ZStack {
            
            VStack {
                ZStack {
                    Image.Instruction
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: Color.TPRColor.SecondaryPurple ,radius: 10)
                    
                    Text("TIME TO VOTE! PLAYER WITH THE MOST VOTES WILL LOSE POINTS.")
                        .foregroundStyle(Color.white)
                        .customFont(.regular, 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 34)
                }
                .padding(.top, 80)
                .padding(.bottom, 40)
                
                ForEach(0..<connectivityManager.connectedPeers.count) { index in
                    HomeButton(title: connectivityManager.connectedPeers[index].displayName.uppercased(), isSelected: choosenPlayer == connectivityManager.connectedPeers[index].displayName)
                        .onTapGesture {
                            choosenPlayer = connectivityManager.connectedPeers[index].displayName
                        }
                }
                
                Spacer()
                
                Button(action: {
                    connectivityManager.sendVoteWithPeerIdToPeers(choosenPlayer)
                    router.navigate(to: .waitingVoteView)
                }, label: {
                    ZStack{
                        if choosenPlayer.isEmpty {
                            Image.DisableButton
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Image.ProceedButton
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        Text("Vote")
                            .foregroundStyle(Color.white)
                            .customFont(.bold, 18)
                    }
                })
                .disabled(choosenPlayer.isEmpty)
                .frame(width: 237, height: 81)
                .offset(y: -15)
            }
            
            if isVotingDone {
                PointResultView(
                    choosenPlayer: choosenPlayer,
                    isVoting: true,
                    isFirstBlood: false,
                    onAction: {
                        router.navigateBack()
                    }
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.TPRColor.PrimaryPurple)
        .navigationBarBackButtonHidden()
        .onAppear {
            if connectivityManager.playersVote.count == 5 {
                isVotingDone = true
                
                var highestVotePLayers = [String: Int]()
                
                for (_, value) in connectivityManager.playersVote {
                    if highestVotePLayers[value] == 1 {
                        highestVotePLayers[value] = (highestVotePLayers[value] ?? 1) + 1
                    } else {
                        highestVotePLayers[value] = 1
                    }
                }
                print("highestVotePLayers", highestVotePLayers)
                
                if let maxValue = highestVotePLayers.values.max() {
                    let votedPlayers = highestVotePLayers.filter { $0.value == maxValue }.keys
                    for votedPlayer in votedPlayers {
                        choosenPlayer += votedPlayer + " "
                        if votedPlayer == connectivityManager.getCandidateName() {
                            missionManager.playerPoints -= 10
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    VotingView()
}
