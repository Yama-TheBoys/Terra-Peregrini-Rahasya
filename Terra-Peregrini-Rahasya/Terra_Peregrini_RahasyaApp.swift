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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                LeaderboardView()
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
                        case .assemble:
                            AssembleView()
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
                        }
                    }
            }
            .environmentObject(router)

        }
    }
}
