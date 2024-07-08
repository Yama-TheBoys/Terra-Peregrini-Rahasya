//
//  Router.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 26/06/24.
//

import SwiftUI

final class Router: ObservableObject {
    
    public indirect enum Destination: Codable, Hashable {
        case minimumreq
        case splashscreen
        case email
        case invitation
        case namecode
        case assemble(String)
        case teamassembled
        case roomreqhost
        case roomcomphost
        case roomcompjoinee
        case selecthome
        case selectroom
        case roomsuccesshost
        case roomsuccessjoinee
        case homenotfound
        case missionIntro(Int)
        case missionMainScreen(Int)
        case leaderboard
        case firstplace
        case others
        case takepicture
        case captured
        case idcardoverview
        case credits
        case votingScreen
        case waitingPlayerView(Destination)
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
