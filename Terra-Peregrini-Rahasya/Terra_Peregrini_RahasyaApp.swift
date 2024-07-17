//
//  Terra_Peregrini_RahasyaApp.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 23/06/24.
//

import SwiftUI

@main
struct Terra_Peregrini_RahasyaApp: App {
    
    @ObservedObject var router = Router()
    @ObservedObject var connectivityManager = ConnectivityManager()
    @ObservedObject var missionManager = MissionManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                DisclaimerView()
//                NameCodeView()
//                MissionMainScreen(mission: 0)
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .minimumreq:
                            MinimumReqView()
                        case .splashscreen:
                            SplashView()
                        case .email:
                            EmailView()
                        case .invitation:
                            InvitationView()
                        case .namecode:
                            NameCodeView()
                        case .assemble(let candidateName):
                            AssembleView(candidateName: candidateName)
                        case .teamassembled:
                            TeamAssembledView()
                        case .roomreqhost:
                            RoomReqHostView()
                        case .roomcomphost:
                            RoomCompHostView()
                        case .roomcompjoinee:
                            RoomCompJoineeView()
                        case .selecthome:
                            SelectHomeHostView()
                        case .selectroom:
                            SelectRoomHostView()
                        case .roomsuccesshost:
                            RoomCompSuccessHostView()
                        case .roomsuccessjoinee:
                            RoomCompSuccessJoineeView()
                        case .homenotfound:
                            HomeNotFoundHostView()
                        case .missionIntro(let mission):
                            MissionIntro(mission: mission)
                        case .missionMainScreen(let mission):
                            MissionMainScreen(mission: mission)
                        case .missionThreeMainScreen(let mission):
                            MissionThreeMainScreen(mission: mission)
                        case .leaderboard:
                            LeaderboardView()
                        case .firstplace:
                            FirstPlaceView()
                        case .others:
                            OthersView()
                        case .takepicture:
                            TakePictureView()
                        case .captured(let photo):
                            CapturedView(capturedImage: photo)
                        case .idcardoverview(let photo):
                            IdCardOverView(capturedImage: photo)
                        case .credits:
                            CreditsView()
                        case .votingScreen:
                            VotingView()
                        case .waitingPlayerView(let destination):
                            WaitingPlayerView(destination: destination)
                        case .waitingVoteView:
                            WaitingVoteView()
                        }
                    }
            }
            .environmentObject(router)
            .environmentObject(connectivityManager)
            .environmentObject(missionManager)
        }
    }
}
