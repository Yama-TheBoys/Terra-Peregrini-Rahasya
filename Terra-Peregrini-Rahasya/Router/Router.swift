//
//  Router.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 26/06/24.
//

import SwiftUI

final class Router: ObservableObject {
    
    public enum Destination: Hashable {
        case minimumreq
        case splashscreen
        case email
        case invitation
        case namecode
        case assemble(candidateName: String)
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
        case captured(UIImage)
        case idcardoverview(UIImage)
        case credits
        case votingScreen
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
