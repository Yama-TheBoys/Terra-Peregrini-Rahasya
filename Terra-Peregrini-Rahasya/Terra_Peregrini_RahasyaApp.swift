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
                                .environmentObject(router)
                        case .splashscreen:
                            SplashView()
                                .environmentObject(router)
                        case .email:
                            EmailView()
                                .environmentObject(router)
                        case .invitation:
                            InvitationView()
                                .environmentObject(router)
                        case .namecode:
                            NameCodeView()
                                .environmentObject(router)
                        case .assemble:
                            AssembleView()
                                .environmentObject(router)
                        case .teamassembled:
                            TeamAssembledView()
                                .environmentObject(router)
                        case .roomreqhost:
                            RoomReqHostView()
                                .environmentObject(router)
                        case .roomcomphost:
                            RoomCompHostView()
                                .environmentObject(router)
                        case .roomcompjoinee:
                            RoomCompJoineeView()
                                .environmentObject(router)
                        case .selecthome:
                            SelectHomeHostView()
                                .environmentObject(router)
                        case .selectroom:
                            SelectRoomHostView()
                                .environmentObject(router)
                        case .missionIntro:
                            MissionIntro()
                                .environmentObject(router)
                        case .missionMainScreen(let mission):
                            MissionMainScreen(mission: mission)
                                .environmentObject(router)
                        case .leaderboard:
                            LeaderboardView()
                                .environmentObject(router)
                        case .firstplace:
                            FirstPlaceView()
                                .environmentObject(router)
                        case .others:
                            OthersView()
                                .environmentObject(router)
                        case .takepicture:
                            TakePictureView()
                                .environmentObject(router)
                        case .captured:
                            CapturedView()
                                .environmentObject(router)
                        case .idcardoverview:
                            IdCardOverView()
                                .environmentObject(router)
                        case .credits:
                            CreditsView()
                                .environmentObject(router)
                        }
                    }
                    .environmentObject(router)
            }
        }
    }
}
