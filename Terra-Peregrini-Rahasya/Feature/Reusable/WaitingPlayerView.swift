//
//  WaitingPlayerView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 05/07/24.
//

import SwiftUI

struct WaitingPlayerView: View {
    @EnvironmentObject var router: Router
    @State var teamProgress = 0.6
    
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
                CircularProgressView(progress: teamProgress)
                    .frame(width: 100)
                    .onChange(of: teamProgress) {
                        if teamProgress == 1 {
                            router.navigate(to: destination)
                        }
                    }
                    
                Text("\(teamProgress * 100, specifier: "%.0f")%")
                    .foregroundStyle(Color.white)
                    .customFont(.bold, 24)
                    .onTapGesture {
                        teamProgress += 0.2
                    }
            }
            
        }
    }
}

#Preview {
    WaitingPlayerView(destination: .missionIntro(0))
}
