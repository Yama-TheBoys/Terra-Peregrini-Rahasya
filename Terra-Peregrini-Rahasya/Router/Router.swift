//
//  Router.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 26/06/24.
//

import SwiftUI

final class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case minimumreq
        case splashscreen
        case email
        case invitation
        case namecode
        case assemble
        case teamassembled
        case roomreqhost
        case roomcomphost
        case roomcompjoinee
        case selecthome
        case selectroom
        case onboard
        case missionIntro
        case missionMainScreen(Int)
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

//typealias Taperable = Codable & Equatable & Hashable
//
//struct Apalah: Taperable {
//    let name: String
//}
