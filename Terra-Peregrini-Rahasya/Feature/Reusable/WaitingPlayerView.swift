//
//  WaitingPlayerView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 05/07/24.
//

import SwiftUI

struct WaitingPlayerView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var connectivityManager: ConnectivityManager
    
    @State var teamProgress = 0.2
    
    let destination: Router.Destination
    
    var body: some View {
        VStack {
            Text("Waiting for all candidates to get ready...")
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
                    .onTapGesture {
                        teamProgress += 0.2
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.TPRColor.PrimaryPurple)
        .navigationBarBackButtonHidden()
        .onAppear {
            connectivityManager.sendMessagePlayerQueued()
        }
        .onChange(of: connectivityManager.playersQueued) {
            self.teamProgress = Double((connectivityManager.playersQueued.count + 1 ) / 5)
            
            if connectivityManager.playersQueued.count == 4 {
                router.navigate(to: destination)
            }
        }
    }
}

#Preview {
    WaitingPlayerView(destination: .missionIntro(0))
}
