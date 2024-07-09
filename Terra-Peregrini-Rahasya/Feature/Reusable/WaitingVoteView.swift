//
//  WaitingVoteView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 09/07/24.
//
import SwiftUI

struct WaitingVoteView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var connectivityManager: ConnectivityManager
    
    @State var teamProgress = 0.2
        
    var body: some View {
        VStack {
            Text("Waiting for all candidates to vote...")
                .foregroundStyle(Color.white)
                .customFont(.regular, 18)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 52)
                .padding(.bottom, 24)
            
            ZStack {
                CircularProgressView(
                    progress: teamProgress,
                    lineWidth: 20,
                    color: Color.TPRColor.LightPurple
                )
                .frame(width: 100)
                    
                Text("\(teamProgress * 100, specifier: "%.0f")%")
                    .foregroundStyle(Color.white)
                    .customFont(.bold, 24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.TPRColor.PrimaryPurple)
        .navigationBarBackButtonHidden()
        .onAppear {
            connectivityManager.sendMessagePlayerQueued()
            waitForOtherPlayer()
        }
        .onChange(of: connectivityManager.playersVote) {
            waitForOtherPlayer()
        }
    }
    
    func waitForOtherPlayer() {
        teamProgress = Double(connectivityManager.playersVote.count) / 5.0
        if connectivityManager.playersVote.count == 5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                router.navigateBack()
            }
        }
    }
}

#Preview {
    WaitingVoteView()
}
