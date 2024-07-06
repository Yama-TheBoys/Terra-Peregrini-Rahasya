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
//            NavigationStack(path: $router.navPath) {
//                DisclaimerView()
//                    .navigationDestination(for: Router.Destination.self) { destination in
//                        switch destination {
//                        case .minimumreq:
//                            MinimumReqView()
//                        case .splashscreen:
//                            SplashView()
//                        case .email:
//                            EmailView()
//                        case .invitation:
//                            InvitationView()
//                        case .namecode:
//                            NameCodeView()
//                        case .assemble:
//                            AssembleView()
//                        case .teamassembled:
//                            TeamAssembledView()
//                        case .roomreqhost:
//                            RoomReqHostView()
//                        case .roomcomphost:
//                            RoomCompHostView()
//                        case .roomcompjoinee:
//                            RoomCompJoineeView()
//                        case .selecthome:
//                            SelectHomeHostView()
//                        case .selectroom:
//                            SelectRoomHostView()
//                        case .missionIntro(let mission):
//                            MissionIntro(mission: mission)
//                        case .missionMainScreen(let mission):
//                            MissionMainScreen(mission: mission)
//                        case .votingScreen:
//                            VotingView()
//                        }
//                    }
//            }
//            .environmentObject(router)
            CMView()
        }
    }
}
